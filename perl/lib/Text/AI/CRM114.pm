use strict;
use warnings;

# import XS interface into namespace Text::AI::libcrm114
package Text::AI::libcrm114;
BEGIN {
    # execute first, so all constants are defined
    require XSLoader;
    our $VERSION = '0.02';
    XSLoader::load('Text::AI::CRM114', $VERSION);
}

# main package
package Text::AI::CRM114;

=head1 NAME

Text::AI::CRM114 - Perl interface for CRM114

=head1 SYNOPSIS

  use Text::AI::CRM114;
  my $db = Text::AI::CRM114->new(
    Text::AI::CRM114::OSBF_BAYES,
    8*1024*1024, ["Alice", "Macbeth"]);

  $db->learn("Alice", "Alice was beginning to ...");
  $db->learn("Macbeth", "When shall we three meet again ...");

  my @ret = $db->classify_text("The Mole had been working very hard all the morning ...");

  say "Best classification is $ret[1]" unless ($ret[0] != Text::AI::CRM114::OK);

=head1 DESCRIPTION

This module provides a simple Perl interface to C<libcrm114>,
a library that implements several text classification algorithms.


=cut

use Carp;

# no exports
my $debug = 0;

=head1 CONSTANTS

C<libcrm114> uses several constants as status return values and to
set the classification algorithm of a new datablock. -- These constants
are accessible in this module's namespace, for example
C<Text::AI::CRM114::OK> and C<Text::AI::CRM114::OSB_WINNOW>.

=cut
use constant {
    OK                     => Text::AI::libcrm114::OK,
    UNK                    => Text::AI::libcrm114::UNK,
    BADARG                 => Text::AI::libcrm114::BADARG,
    NOMEM                  => Text::AI::libcrm114::NOMEM,
    REGEX_ERR              => Text::AI::libcrm114::REGEX_ERR,
    FULL                   => Text::AI::libcrm114::FULL,
    CLASS_FULL             => Text::AI::libcrm114::CLASS_FULL,
    OPEN_FAILED            => Text::AI::libcrm114::OPEN_FAILED,
    NOT_YET_IMPLEMENTED    => Text::AI::libcrm114::NOT_YET_IMPLEMENTED,
    FROMSTART              => Text::AI::libcrm114::FROMSTART,
    FROMNEXT               => Text::AI::libcrm114::FROMNEXT,
    FROMEND                => Text::AI::libcrm114::FROMEND,
    NEWEND                 => Text::AI::libcrm114::NEWEND,
    FROMCURRENT            => Text::AI::libcrm114::FROMCURRENT,
    NOCASE                 => Text::AI::libcrm114::NOCASE,
    ABSENT                 => Text::AI::libcrm114::ABSENT,
    BASIC                  => Text::AI::libcrm114::BASIC,
    BACKWARDS              => Text::AI::libcrm114::BACKWARDS,
    LITERAL                => Text::AI::libcrm114::LITERAL,
    NOMULTILINE            => Text::AI::libcrm114::NOMULTILINE,
    BYCHAR                 => Text::AI::libcrm114::BYCHAR,
    STRING                 => Text::AI::libcrm114::STRING,
    APPEND                 => Text::AI::libcrm114::APPEND,
    REFUTE                 => Text::AI::libcrm114::REFUTE,
    MICROGROOM             => Text::AI::libcrm114::MICROGROOM,
    MARKOVIAN              => Text::AI::libcrm114::MARKOVIAN,
    OSB_BAYES              => Text::AI::libcrm114::OSB_BAYES,
    OSB                    => Text::AI::libcrm114::OSB,
    CORRELATE              => Text::AI::libcrm114::CORRELATE,
    OSB_WINNOW             => Text::AI::libcrm114::OSB_WINNOW,
    WINNOW                 => Text::AI::libcrm114::WINNOW,
    CHI2                   => Text::AI::libcrm114::CHI2,
    UNIQUE                 => Text::AI::libcrm114::UNIQUE,
    ENTROPY                => Text::AI::libcrm114::ENTROPY,
    OSBF                   => Text::AI::libcrm114::OSBF,
    OSBF_BAYES             => Text::AI::libcrm114::OSBF_BAYES,
    HYPERSPACE             => Text::AI::libcrm114::HYPERSPACE,
    UNIGRAM                => Text::AI::libcrm114::UNIGRAM,
    CROSSLINK              => Text::AI::libcrm114::CROSSLINK,
    READLINE               => Text::AI::libcrm114::READLINE,
    DEFAULT                => Text::AI::libcrm114::DEFAULT,
    SVM                    => Text::AI::libcrm114::SVM,
    FSCM                   => Text::AI::libcrm114::FSCM,
    NEURAL_NET             => Text::AI::libcrm114::NEURAL_NET,
    ERASE                  => Text::AI::libcrm114::ERASE,
    PCA                    => Text::AI::libcrm114::PCA,
    BOOST                  => Text::AI::libcrm114::BOOST,
    FLAGS_CLASSIFIERS_MASK => Text::AI::libcrm114::FLAGS_CLASSIFIERS_MASK,
};

=head1 METHODS

=over

=item Text::AI::CRM114->new($flags, $datasize, $classref)

Creates a new instance.

=over

=item $flags

sets the classification algorithm, recommended values are 

C<Text::AI::CRM114::OSB_BAYES> (default), 
C<Text::AI::CRM114::OSB_WINNOW>, or
C<Text::AI::CRM114::HYPERSPACE>.
C<libcrm114> includes some more algorithms (SVM, PCA, FSCM) which
may or may not be production ready.

=item $datasize

the memory size of learned data (default is 4 Mb).
Note that some algorithms have to grow the datasize when learning.

=item $classref

a list of classes passed by reference (default: C<['A', 'B']>).

=back

=cut

sub new {
    my ($class, $flags, $datasize, $classref) = @_;
    my $self = {};
    bless ($self, $class);

    carp sprintf("%s->(0x%x, %s, %s)", $class,
        $flags // 0, $datasize // "undef",
        $classref // "undef") if ($debug);

    # default values
    $flags    //= OSB;
    $datasize //= 4*1024*1024; # 4Mb
    $classref //= ['A', 'B'];

    # now set up the C structs
    my $cb = Text::AI::libcrm114::new_cb();
    Text::AI::libcrm114::cb_setflags($cb, $flags);
    Text::AI::libcrm114::cb_setclassdefaults($cb);
    Text::AI::libcrm114::cb_setdatablock_size($cb, $datasize);
    Text::AI::libcrm114::cb_setblockdefaults($cb);
    $self->{classmap} = {};
    my @classes = @$classref;
    for (my $i=0; $i < scalar(@classes); $i++) {
        Text::AI::libcrm114::cb_setclassname($cb, $i, $classes[$i]);
        $self->{classmap}->{$classes[$i]} = $i;
    }
    $self->{db} = Text::AI::libcrm114::new_db($cb);
    return $self;
}

=item Text::AI::CRM114->readfile($filename)

Creates a new instance by reading a previously saved CRM114 DB from C<$filename>.

=cut

sub readfile {
    my ($class, $filename) = @_;
    my $self = {};
    bless ($self, $class);

    carp "$class->readfile($filename)" if ($debug);

    $self->{db} = Text::AI::libcrm114::db_read_bin($filename);
    unless ($self->{db}) {
        croak("Error in Text::AI::libcrm114::db_read_bin");
    }
    $self->{mmap} = 1;

    my @classes = Text::AI::libcrm114::db_getclasses($self->{db});
    $self->{classmap} = {};
    for (my $i=0; $i < scalar(@classes); $i++) {
        $self->{classmap}->{$classes[$i]} = $i;
    }
    return $self;
}

=item $db->getclasses()

Returns a hash reference to the DB's classes.
This hash associates the class names (keys) with the internal integer index (values).

=cut

sub getclasses {
    my $self = shift;
    return $self->{classmap};
}

sub DESTROY {
    my $self = shift;
    carp "DESTROYING $self" if ($debug);
    if (defined($self->{mmap}) and $self->{mmap}) {
        Text::AI::libcrm114::db_close_bin($self->{db});
    }

    # TODO: check if and how to call C free()
    #Text::AI::libcrm114::DESTROY($self->{db});
    #carp "DESTROYING ..." if ($debug);
    return;
}

=item $db->writefile($filename)

Writes the DB into a (binary) file.

=cut

sub writefile {
    my ($self, $filename) = @_;
    carp "writefile($filename)" if ($debug);
    return Text::AI::libcrm114::db_write_bin($self->{db}, $filename);
}

=item $db->learn($class, $text)

Learn some text of a given class.

=cut

sub learn {
    my ($self, $class, $text) = @_;
    croak("learn requires category and text as arguments")
        unless (defined $class && defined $text);

    my $err = Text::AI::libcrm114::learn_text($self->{db}, $self->{classmap}->{$class}, $text, length($text));
    if ($err != OK) {
        croak("Text::AI::libcrm114::learn_text failed and returns $err -- " . Text::AI::libcrm114::strerror($err));
    }
}

=item $db->classify($text, $verbatim)

Classify the text.

The normal working mode without the optional C<$verbatim> flag adjusts the
return values to be more useful with two classes (e.g. spam/ham).
If the flag is given then the values are passed unchanged as they come
from C<libcrm114>. In practice this is only relevant if you use more
than two classes. (Then you have to consider the success/non-success classes
and probably want to add a method to retrieve the single per-class results.)

Returns a list of five scalar values:

=over

=item $err

A numeric error code, should be C<Text::AI::libcrm114::OK>

=item $errmsg

A short error message (for error display or logging).

=item $class

The name of the best matching class.

=item $prob

The success probability. Normally the probability of the matching class (with 0.5 <= $prob <= 1)

With C<$verbatim> this is the success probability, i.e. with two classes the
probability of the first class and with multiple classes the sum of
probabilities for all successful classes (with 0 <= $prob <= 1).

=item $pR

The logarithmic probability ratio i.e. C<log10($prob) - log10(1-$prob)>
(theorethic range is 0 <= $pR <= 340, limited by floating point precision;
but in practice a p = .99 yields a pR = 2, so high values are rather unusual).

With C<$verbatim> this is the ratio between all success and all non-success
probabilities, so for a non-successful result the value can also be negative
(range -340 <= $pR <= 340).

=back

=cut

sub classify {
    my ($self, $text, $verbatim) = @_;
    croak("classify_text requires a text as argument")
        unless (defined $text);

    my ($err, $class, $prob, $pR, $unk) = Text::AI::libcrm114::classify($self->{db}, $text, length($text));
    my $errmsg = Text::AI::libcrm114::strerror($err);

    if (!$verbatim and $self->{classmap}->{$class}) {
        # change prob and pR values relative to second class
        $prob = 1 - $prob;
        $pR = -$pR;
    }

    return ($err, $errmsg, $class, $prob, $pR);
}

=back

=head1 ISSUES

This is my first attempt to write a Perl module, so all hints and improvements
are appreciated.

I would like to hide the constants from C<Text::AI::libcrm114>.
I guess it is impossible to eliminate the error codes (unless one wants
to completely hide them from the user and simply C<croak> on every error).
But at least for the algorithm selection I consider string arguments, i.e.
the user should give us the string C<OSBF> and we map it to C<Text::AI::libcrm114::OSBF>.

I wonder if we should ensure Text::AI::libcrm114::OK maps to 0, as this makes
the caller's return value checking easier.
Currently this is trivial because it already is 0 in C<libcrm114>.
If that should change we would have to insert a rewrite into
every XS call to a C function (ugly, but maybe worth it).

I am still not sure if the C memory management works correctly.

Another issue is Unicode support, which is missing in C<libcrm114>, so it might
be a good thing to convert unicode strings into some 8-bit encoding.
As long as no string contains \0-values nothing bad[tm] will happen,
but I assume that Unicode strings will internally cause wrong tokenization
(this should be checked in C<libtre>).

=head1 SEE ALSO

CRM114 homepage: L<http://crm114.sourceforge.net/>

AI::CRM114, a module using the crm language interpreter: L<https://metacpan.org/module/AI::CRM114>

=head1 HISTORY

v0.02 initial release

=head1 AUTHOR

Martin Schuette, E<lt>info@mschuette.nameE<gt>

=head1 COPYRIGHT AND LICENSE

Perl module: Copyright (C) 2012 by Martin Schuette

libcrm114: Copyright (C) 2009-2010 by William S. Yerazunis

This library is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License version 3.


=cut

1;
__END__
