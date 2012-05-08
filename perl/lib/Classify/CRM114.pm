package Classify::CRM114;

use 5.012000;
use strict;
use warnings;
use Carp;

use Classify::libcrm114;

our %EXPORT_TAGS = ( 'all' => [ qw(
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

my $debug = 1;

sub new {
    my ($class, $flags, $datasize, $classref) = @_;
    my $self = {};
    bless ($self, $class);

    carp "$class->new("
      . join(", ", map((defined $_ ? $_ : "undef"), ($flags, $datasize, $classref)))
      . ")" if ($debug);

    # default values
    $flags    //= Classify::libcrm114::OSB;
    $datasize //= 4*1024*1024; # 4Mb
    $classref //= ['A', 'B'];

    # now set up the C structs
    my $cb = Classify::libcrm114::new_cb();
    Classify::libcrm114::cb_setflags($cb, $flags);
    Classify::libcrm114::cb_setclassdefaults($cb);
    Classify::libcrm114::cb_setblockdefaults($cb);
    Classify::libcrm114::cb_setdatablock_size($cb, $datasize);
    $self->{classmap} = {};
    my @classes = @$classref;
    for (my $i=0; $i < scalar(@classes); $i++) {
        Classify::libcrm114::cb_setclassname($cb, $i, $classes[$i]);
        $self->{classmap}->{$classes[$i]} = $i;
    }
    $self->{db} = Classify::libcrm114::new_db($cb);
    return $self;
}

sub readfile {
    my ($class, $filename) = @_;
    my $self = {};
    bless ($self, $class);

    carp "$class->readfile($filename)" if ($debug);

    $self->{db} = Classify::libcrm114::db_open_mmap($filename);
    unless ($self->{db}) {
        croak("Error in Classify::libcrm114::db_open_mmap");
    }
    $self->{mmap} = 1;

    my @classes = Classify::libcrm114::db_getclasses($self->{db});
    $self->{classmap} = {};
    for (my $i=0; $i < scalar(@classes); $i++) {
        $self->{classmap}->{$classes[$i]} = $i;
    }
    return $self;
}

sub getclasses {
	my $self = shift;
	return $self->{classmap};
}

sub DESTROY {
    my $self = shift;
    carp "DESTROYING $self" if ($debug);
    if (defined($self->{mmap}) and $self->{mmap}) {
        Classify::libcrm114::db_close_mmap($self->{db});
    }

    # TODO: check if and how to call C free()
    #Classify::libcrm114::DESTROY($self->{db});
    #carp "DESTROYING ..." if ($debug);
    return;
}

sub writefile {
    my ($self, $filename) = @_;
    carp "writefile($filename)" if ($debug);
    return Classify::libcrm114::db_write_mmap($self->{db}, $filename);
}

sub learn {
    my ($self, $class, $text) = @_;
    croak("learn_text requires category and text as arguments")
      unless (defined $class && defined $text);

    my $err = Classify::libcrm114::learn_text($self->{db}, $self->{classmap}->{$class}, $text, length($text));
    if ($err != Classify::libcrm114::OK) {
        croak("Classify::libcrm114::learn_text failed and returns " . Classify::libcrm114::strerror($err));
    }
}

sub classify {
    my ($self, $text) = @_;
    croak("classify_text requires a text as argument")
      unless (defined $text);

    my ($err, $class, $prob, $pR, $unk) = Classify::libcrm114::classify($self->{db}, $text, length($text));
    my $errmsg = Classify::libcrm114::strerror($err);
    return ($err, $errmsg, $class, $prob, $pR, $unk);
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Classify::CRM114 - Perl interface for CRM114

=head1 SYNOPSIS

  use Classify::CRM114;
  ...

=head1 DESCRIPTION

A simple Perl binding for functions in C<libcrm114>. You probably do not want to use
this module directly. -- Classify::CRM114 instead, which hides some of the low level
functions inside a Perl object.

=head2 EXPORT

None by default.

=head1 SEE ALSO

CRM114 homepage: L<http://crm114.sourceforge.net/>

=head1 AUTHOR

Martin Schuette, E<lt>info@mschuette.nameE<gt>

=head1 COPYRIGHT AND LICENSE

Perl module: Copyright (C) 2012 by Martin Schuette

libcrm114: Copyright (C) 2009-2010 by William S. Yerazunis

This library is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License version 3.


=cut
