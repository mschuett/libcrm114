package Classify::libcrm114;

use 5.012000;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Classify::libcrm114 ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	__srget
	__swbuf
	asprintf
	cb_getdimensions
	cb_read_text
	cb_read_text_fp
	cb_reset
	cb_setblockdefaults
	cb_setclassdefaults
	cb_setdefaults
	cb_setflags
	cb_setpipeline
	cb_setregex
	cb_write_text
	cb_write_text_fp
	classify_features
	classify_features_fscm
	classify_features_hyperspace
	classify_features_markov
	classify_features_pca
	classify_features_svm
	classify_text
	classify_text_bit_entropy
	clearerr
	clearerr_unlocked
	ctermid
	ctermid_r
	db_close_mmap
	db_open_mmap
	db_read_text
	db_read_text_fp
	db_write_mmap
	db_write_text
	db_write_text_fp
	dump_cb
	fclose
	fcloseall
	fdopen
	feature_sort_unique
	feof
	feof_unlocked
	ferror
	ferror_unlocked
	fflush
	fgetc
	fgetln
	fgetpos
	fgets
	fileno
	fileno_unlocked
	flockfile
	fmtcheck
	fopen
	fprintf
	fpurge
	fputc
	fputs
	fread
	free
	freopen
	fscanf
	fseek
	fseeko
	fsetpos
	ftell
	ftello
	ftruncate
	ftrylockfile
	funlockfile
	funopen
	fwrite
	getc
	getc_unlocked
	getchar
	getchar_unlocked
	getdelim
	gets
	getw
	learn_features
	learn_features_fscm
	learn_features_hyperspace
	learn_features_markov
	learn_features_pca
	learn_features_svm
	learn_text
	learn_text_bit_entropy
	lseek
	mmap
	new_cb
	new_db
	pclose
	perror
	popen
	printf
	putc
	putc_unlocked
	putchar
	putchar_unlocked
	puts
	putw
	remove
	rename
	renameat
	rewind
	scanf
	setbuf
	setbuffer
	setlinebuf
	setvbuf
	show_result
	show_result_class
	snprintf
	sprintf
	sscanf
	strerror
	strnhash
	tempnam
	tmpfile
	tmpnam
	truncate
	ungetc
	vasprintf
	vdprintf
	vector_tokenize
	vfprintf
	vfscanf
	vprintf
	vscanf
	vsnprintf
	vsprintf
	vsscanf
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&Classify::libcrm114::constant not defined" if $constname eq 'constant';
    my ($error, $val) = constant($constname);
    if ($error) { croak $error; }
    {
	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
#XXX	if ($] >= 5.00561) {
#XXX	    *$AUTOLOAD = sub () { $val };
#XXX	}
#XXX	else {
	    *$AUTOLOAD = sub { $val };
#XXX	}
    }
    goto &$AUTOLOAD;
}

require XSLoader;
XSLoader::load('Classify::libcrm114', $VERSION);

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Classify::libcrm114 - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Classify::libcrm114;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Classify::libcrm114, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.

=head2 Exportable functions

  int __srget(FILE *)
  int __swbuf(int, FILE *)
  int asprintf(char **, const char *, ...) __attribute__((__format__ (__printf__, 2, 3)))
  void clearerr(FILE *)
  void clearerr_unlocked(FILE *)
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
  CRM114_ERR crm114_cb_setpipeline
    ( CRM114_CONTROLBLOCK *p_cb,
      int pipe_len, int pipe_iters,
      const int pipe_coeffs[UNIFIED_ITERS_MAX][UNIFIED_WINDOW_MAX] )
  CRM114_ERR crm114_cb_setregex(CRM114_CONTROLBLOCK *p_cb, const char regex[],
         int regex_len)
  CRM114_ERR crm114_cb_write_text(const CRM114_CONTROLBLOCK *cb, const char filename[])
  CRM114_ERR crm114_cb_write_text_fp(const CRM114_CONTROLBLOCK *cb, FILE *fp)
  CRM114_ERR crm114_classify_features (CRM114_DATABLOCK *db,
         struct crm114_feature_row fr[],
         long *nfr,
         CRM114_MATCHRESULT *result)
  CRM114_ERR crm114_classify_features_fscm(const CRM114_DATABLOCK *db,
      const struct crm114_feature_row features[],
      long nfr,
      CRM114_MATCHRESULT *result)
  CRM114_ERR crm114_classify_features_hyperspace(const CRM114_DATABLOCK *db,
            const struct crm114_feature_row features[],
            long featurecount,
            CRM114_MATCHRESULT *result)
  CRM114_ERR crm114_classify_features_markov (const CRM114_DATABLOCK *db,
         const struct crm114_feature_row features[],
         long featurecount,
         CRM114_MATCHRESULT *result)
  CRM114_ERR crm114_classify_features_pca(CRM114_DATABLOCK *db,
     const struct crm114_feature_row features[],
     long nfr, CRM114_MATCHRESULT *result)
  CRM114_ERR crm114_classify_features_svm(CRM114_DATABLOCK *db,
     const struct crm114_feature_row features[], long nfr,
     CRM114_MATCHRESULT *result)
  CRM114_ERR crm114_classify_text (CRM114_DATABLOCK *db, const char text[],
     long textlen, CRM114_MATCHRESULT *result)
  CRM114_ERR crm114_classify_text_bit_entropy(const CRM114_DATABLOCK *db,
         const char text[], long textlen,
         CRM114_MATCHRESULT *result)
  int crm114_db_close_mmap(CRM114_DATABLOCK *db)
  CRM114_DATABLOCK *crm114_db_open_mmap(const char filename[])
  CRM114_DATABLOCK *crm114_db_read_text(const char filename[])
  CRM114_DATABLOCK *crm114_db_read_text_fp(FILE *fp)
  CRM114_ERR crm114_db_write_mmap(const CRM114_DATABLOCK *db, const char filename[])
  CRM114_ERR crm114_db_write_text(const CRM114_DATABLOCK *db, const char filename[])
  CRM114_ERR crm114_db_write_text_fp(const CRM114_DATABLOCK *db, FILE *fp)
  char *crm114_dump_cb(CRM114_CONTROLBLOCK *cb)
  void crm114_feature_sort_unique
(
 struct crm114_feature_row fr[],
 long *nfr,
 int sort,
 int unique
 )
  void crm114_free(void *p)
  CRM114_ERR crm114_learn_features (CRM114_DATABLOCK **db,
      int whichclass,
      struct crm114_feature_row fr[],
      long *nfr)
  CRM114_ERR crm114_learn_features_fscm (CRM114_DATABLOCK **db,
           int whichclass,
           const struct crm114_feature_row features[],
           long featurecount)
  CRM114_ERR crm114_learn_features_hyperspace (CRM114_DATABLOCK **db,
          int whichclass,
          const struct crm114_feature_row features[],
          long featurecount)
  CRM114_ERR crm114_learn_features_markov (CRM114_DATABLOCK **db,
      int icls,
      const struct crm114_feature_row features[],
      long featurecount)
  CRM114_ERR crm114_learn_features_pca(CRM114_DATABLOCK **db,
         int class,
         const struct crm114_feature_row features[],
         long featurecount)
  CRM114_ERR crm114_learn_features_svm(CRM114_DATABLOCK **db,
         int class,
         const struct crm114_feature_row features[],
         long featurecount)
  CRM114_ERR crm114_learn_text (CRM114_DATABLOCK **db, int whichclass,
         const char text[], long textlen)
  CRM114_ERR crm114_learn_text_bit_entropy(CRM114_DATABLOCK **db,
      int whichclass, const char text[],
      long textlen)
  CRM114_CONTROLBLOCK *crm114_new_cb(void)
  CRM114_DATABLOCK *crm114_new_db (CRM114_CONTROLBLOCK *p_cb)
  void crm114_show_result(const char name[], const CRM114_MATCHRESULT *r)
  void crm114_show_result_class(const CRM114_MATCHRESULT *r, int icls)
  const char *crm114_strerror(CRM114_ERR err)
  unsigned int crm114_strnhash (const char *str, long len)
  CRM114_ERR crm114_vector_tokenize
(
 const char *txtptr,
 long txtstart,
 long txtlen,
 const CRM114_CONTROLBLOCK *p_cb,
 struct crm114_feature_row frs[],
 long frslen,
 long *frs_out,
 long *next_offset
 )
  char *ctermid(char *)
  char *ctermid_r(char *)
  int fclose(FILE *)
  void fcloseall(void)
  FILE *fdopen(int, const char *)
  int feof(FILE *)
  int feof_unlocked(FILE *)
  int ferror(FILE *)
  int ferror_unlocked(FILE *)
  int fflush(FILE *)
  int fgetc(FILE *)
  char *fgetln(FILE *, size_t *)
  int fgetpos(FILE * , fpos_t * )
  char *fgets(char * , int, FILE * )
  int fileno(FILE *)
  int fileno_unlocked(FILE *)
  void flockfile(FILE *)
  const char *fmtcheck(const char *, const char *) __attribute__((__format_arg__ (2)))
  FILE *fopen(const char * , const char * )
  int fprintf(FILE * , const char * , ...)
  int fpurge(FILE *)
  int fputc(int, FILE *)
  int fputs(const char * , FILE * )
  size_t fread(void * , size_t, size_t, FILE * )
  FILE *freopen(const char * , const char * , FILE * )
  int fscanf(FILE * , const char * , ...)
  int fseek(FILE *, long, int)
  int fseeko(FILE *, __off_t, int)
  int fsetpos(FILE *, const fpos_t *)
  long ftell(FILE *)
  __off_t ftello(FILE *)
  int ftruncate(int, __off_t)
  int ftrylockfile(FILE *)
  void funlockfile(FILE *)
  FILE *funopen(const void *,
     int (*)(void *, char *, int),
     int (*)(void *, const char *, int),
     fpos_t (*)(void *, fpos_t, int),
     int (*)(void *))
  size_t fwrite(const void * , size_t, size_t, FILE * )
  int getc(FILE *)
  int getc_unlocked(FILE *)
  int getchar(void)
  int getchar_unlocked(void)
  ssize_t getdelim(char ** , size_t * , int,
     FILE * )
  char *gets(char *)
  int getw(FILE *)
  __off_t lseek(int, __off_t, int)
  void *mmap(void *, size_t, int, int, int, __off_t)
  int pclose(FILE *)
  void perror(const char *)
  FILE *popen(const char *, const char *)
  int printf(const char * , ...)
  int putc(int, FILE *)
  int putc_unlocked(int, FILE *)
  int putchar(int)
  int putchar_unlocked(int)
  int puts(const char *)
  int putw(int, FILE *)
  int remove(const char *)
  int rename(const char *, const char *)
  int renameat(int, const char *, int, const char *)
  void rewind(FILE *)
  int scanf(const char * , ...)
  void setbuf(FILE * , char * )
  void setbuffer(FILE *, char *, int)
  int setlinebuf(FILE *)
  int setvbuf(FILE * , char * , int, size_t)
  int snprintf(char * , size_t, const char * ,
     ...) __attribute__((__format__ (__printf__, 3, 4)))
  int sprintf(char * , const char * , ...)
  int sscanf(const char * , const char * , ...)
  char *tempnam(const char *, const char *)
  FILE *tmpfile(void)
  char *tmpnam(char *)
  int truncate(const char *, __off_t)
  int ungetc(int, FILE *)
  int vasprintf(char **, const char *, __va_list)
     __attribute__((__format__ (__printf__, 2, 0)))
  int vdprintf(int, const char * , __va_list)
  int vfprintf(FILE * , const char * ,
     __va_list)
  int vfscanf(FILE * , const char * , __va_list)
     __attribute__((__format__ (__scanf__, 2, 0)))
  int vprintf(const char * , __va_list)
  int vscanf(const char * , __va_list) __attribute__((__format__ (__scanf__, 1, 0)))
  int vsnprintf(char * , size_t, const char * ,
     __va_list) __attribute__((__format__ (__printf__, 3, 0)))
  int vsprintf(char * , const char * ,
     __va_list)
  int vsscanf(const char * , const char * , __va_list)
     __attribute__((__format__ (__scanf__, 2, 0)))



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Martin Schuette, E<lt>info@mschuette.nameE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012 by Martin Schuette

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
