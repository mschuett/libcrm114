package Classify::libcrm114;

use 5.012000;
use strict;
use warnings;
use Carp;

# no exports
our $VERSION = '0.02';

require XSLoader;
XSLoader::load('Classify::libcrm114', $VERSION);

1;
__END__
=head1 NAME

Classify::libcrm114 - Perl interface for libcrm114

=head1 DESCRIPTION

A simple Perl binding for functions in C<libcrm114>. You probably do not want to use
this module directly. -- Classify::CRM114 instead, which hides some of the low level
functions inside a Perl object.

=head2 EXPORT

None by default.

=head2 Exportable functions

  void crm114_cb_getdimensions(const CRM114_CONTROLBLOCK *p_cb,
        int *pipe_len, int *pipe_iters)
  CRM114_CONTROLBLOCK *crm114_cb_read_text(const char filename[])
  CRM114_CONTROLBLOCK *crm114_cb_read_text_fp(FILE *fp)
  void crm114_cb_reset(CRM114_CONTROLBLOCK *p_cb)
  void crm114_cb_setblockdefaults(CRM114_CONTROLBLOCK *p_cb)
  void crm114_cb_setclassdefaults(CRM114_CONTROLBLOCK *p_cb)
  void crm114_cb_setdefaults(CRM114_CONTROLBLOCK *p_cb)
  CRM114_ERR crm114_cb_setflags
    (CRM114_CONTROLBLOCK *p_cb, unsigned long long flags)
  CRM114_ERR crm114_cb_setregex(CRM114_CONTROLBLOCK *p_cb, const char regex[],
         int regex_len)
  CRM114_ERR crm114_cb_write_text(const CRM114_CONTROLBLOCK *cb, const char filename[])
  CRM114_ERR crm114_cb_write_text_fp(const CRM114_CONTROLBLOCK *cb, FILE *fp)
  CRM114_ERR crm114_classify_text (CRM114_DATABLOCK *db, const char text[],
     long textlen, CRM114_MATCHRESULT *result)
  int crm114_db_close_bin(CRM114_DATABLOCK *db)
  CRM114_DATABLOCK *crm114_db_read_bin(const char filename[])
  CRM114_DATABLOCK *crm114_db_read_text(const char filename[])
  CRM114_DATABLOCK *crm114_db_read_text_fp(FILE *fp)
  CRM114_ERR crm114_db_write_bin(const CRM114_DATABLOCK *db, const char filename[])
  CRM114_ERR crm114_db_write_text(const CRM114_DATABLOCK *db, const char filename[])
  CRM114_ERR crm114_db_write_text_fp(const CRM114_DATABLOCK *db, FILE *fp)
  void crm114_free(void *p)
  CRM114_ERR crm114_learn_text (CRM114_DATABLOCK **db, int whichclass,
         const char text[], long textlen)
  CRM114_CONTROLBLOCK *crm114_new_cb(void)
  CRM114_DATABLOCK *crm114_new_db (CRM114_CONTROLBLOCK *p_cb)
  void crm114_show_result(const char name[], const CRM114_MATCHRESULT *r)
  void crm114_show_result_class(const CRM114_MATCHRESULT *r, int icls)
  const char *crm114_strerror(CRM114_ERR err)



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
