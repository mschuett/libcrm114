#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <include/crm114_lib.h>

#include "const-c.inc"

MODULE = Classify::libcrm114		PACKAGE = Classify::libcrm114		PREFIX = crm114_

INCLUDE: const-xs.inc

int
__srget(arg0)
	FILE *	arg0

int
__swbuf(arg0, arg1)
	int	arg0
	FILE *	arg1

int
asprintf(arg0, arg1, ...)
	char **	arg0
	const char *	arg1

void
clearerr(arg0)
	FILE *	arg0

void
clearerr_unlocked(arg0)
	FILE *	arg0

void
crm114_cb_getdimensions(p_cb, pipe_len, pipe_iters)
	const CRM114_CONTROLBLOCK *	p_cb
	int *	pipe_len
	int *	pipe_iters

CRM114_CONTROLBLOCK *
crm114_cb_read_text(filename)
	char	filename[]

CRM114_CONTROLBLOCK *
crm114_cb_read_text_fp(fp)
	FILE *	fp

void
crm114_cb_reset(p_cb)
	CRM114_CONTROLBLOCK *	p_cb

void
crm114_cb_setblockdefaults(p_cb)
	CRM114_CONTROLBLOCK *	p_cb

void
crm114_cb_setclassdefaults(p_cb)
	CRM114_CONTROLBLOCK *	p_cb

void
crm114_cb_setdefaults(p_cb)
	CRM114_CONTROLBLOCK *	p_cb

CRM114_ERR
crm114_cb_setflags(p_cb, flags)
	CRM114_CONTROLBLOCK *	p_cb
	unsigned long long	flags

CRM114_ERR
crm114_cb_setpipeline(p_cb, pipe_len, pipe_iters, pipe_coeffs)
	CRM114_CONTROLBLOCK *	p_cb
	int	pipe_len
	int	pipe_iters
	int	pipe_coeffs[UNIFIED_ITERS_MAX][UNIFIED_WINDOW_MAX]

CRM114_ERR
crm114_cb_setregex(p_cb, regex, regex_len)
	CRM114_CONTROLBLOCK *	p_cb
	char	regex[]
	int	regex_len

CRM114_ERR
crm114_cb_write_text(cb, filename)
	const CRM114_CONTROLBLOCK *	cb
	char	filename[]

CRM114_ERR
crm114_cb_write_text_fp(cb, fp)
	const CRM114_CONTROLBLOCK *	cb
	FILE *	fp

CRM114_ERR
crm114_classify_features(db, fr, nfr, result)
	CRM114_DATABLOCK *	db
	struct crm114_feature_row	fr[]
	long *	nfr
	CRM114_MATCHRESULT *	result

CRM114_ERR
crm114_classify_features_fscm(db, features, nfr, result)
	const CRM114_DATABLOCK *	db
	struct crm114_feature_row	features[]
	long	nfr
	CRM114_MATCHRESULT *	result

CRM114_ERR
crm114_classify_features_hyperspace(db, features, featurecount, result)
	const CRM114_DATABLOCK *	db
	struct crm114_feature_row	features[]
	long	featurecount
	CRM114_MATCHRESULT *	result

CRM114_ERR
crm114_classify_features_markov(db, features, featurecount, result)
	const CRM114_DATABLOCK *	db
	struct crm114_feature_row	features[]
	long	featurecount
	CRM114_MATCHRESULT *	result

CRM114_ERR
crm114_classify_features_pca(db, features, nfr, result)
	CRM114_DATABLOCK *	db
	struct crm114_feature_row	features[]
	long	nfr
	CRM114_MATCHRESULT *	result

CRM114_ERR
crm114_classify_features_svm(db, features, nfr, result)
	CRM114_DATABLOCK *	db
	struct crm114_feature_row	features[]
	long	nfr
	CRM114_MATCHRESULT *	result

CRM114_ERR
crm114_classify_text(db, text, textlen, result)
	CRM114_DATABLOCK *	db
	char	text[]
	long	textlen
	CRM114_MATCHRESULT *	result

CRM114_ERR
crm114_classify_text_bit_entropy(db, text, textlen, result)
	const CRM114_DATABLOCK *	db
	char	text[]
	long	textlen
	CRM114_MATCHRESULT *	result

int
crm114_db_close_mmap(db)
	CRM114_DATABLOCK *	db

CRM114_DATABLOCK *
crm114_db_open_mmap(filename)
	char	filename[]

CRM114_DATABLOCK *
crm114_db_read_text(filename)
	char	filename[]

CRM114_DATABLOCK *
crm114_db_read_text_fp(fp)
	FILE *	fp

CRM114_ERR
crm114_db_write_mmap(db, filename)
	const CRM114_DATABLOCK *	db
	char	filename[]

CRM114_ERR
crm114_db_write_text(db, filename)
	const CRM114_DATABLOCK *	db
	char	filename[]

CRM114_ERR
crm114_db_write_text_fp(db, fp)
	const CRM114_DATABLOCK *	db
	FILE *	fp

char *
crm114_dump_cb(cb)
	CRM114_CONTROLBLOCK *	cb

void
crm114_feature_sort_unique(fr, nfr, sort, unique)
	struct crm114_feature_row	fr[]
	long *	nfr
	int	sort
	int	unique

void
crm114_free(p)
	void *	p

CRM114_ERR
crm114_learn_features(db, whichclass, fr, nfr)
	CRM114_DATABLOCK **	db
	int	whichclass
	struct crm114_feature_row	fr[]
	long *	nfr

CRM114_ERR
crm114_learn_features_fscm(db, whichclass, features, featurecount)
	CRM114_DATABLOCK **	db
	int	whichclass
	struct crm114_feature_row	features[]
	long	featurecount

CRM114_ERR
crm114_learn_features_hyperspace(db, whichclass, features, featurecount)
	CRM114_DATABLOCK **	db
	int	whichclass
	struct crm114_feature_row	features[]
	long	featurecount

CRM114_ERR
crm114_learn_features_markov(db, icls, features, featurecount)
	CRM114_DATABLOCK **	db
	int	icls
	struct crm114_feature_row	features[]
	long	featurecount

CRM114_ERR
crm114_learn_features_pca(db, class, features, featurecount)
	CRM114_DATABLOCK **	db
	int	class
	struct crm114_feature_row	features[]
	long	featurecount

CRM114_ERR
crm114_learn_features_svm(db, class, features, featurecount)
	CRM114_DATABLOCK **	db
	int	class
	struct crm114_feature_row	features[]
	long	featurecount

CRM114_ERR
crm114_learn_text(db, whichclass, text, textlen)
	CRM114_DATABLOCK **	db
	int	whichclass
	char	text[]
	long	textlen

CRM114_ERR
crm114_learn_text_bit_entropy(db, whichclass, text, textlen)
	CRM114_DATABLOCK **	db
	int	whichclass
	char	text[]
	long	textlen

CRM114_CONTROLBLOCK *
crm114_new_cb()

CRM114_DATABLOCK *
crm114_new_db(p_cb)
	CRM114_CONTROLBLOCK *	p_cb

void
crm114_show_result(name, r)
	char	name[]
	const CRM114_MATCHRESULT *	r

void
crm114_show_result_class(r, icls)
	const CRM114_MATCHRESULT *	r
	int	icls

const char *
crm114_strerror(err)
	CRM114_ERR	err

unsigned int
crm114_strnhash(str, len)
	const char *	str
	long	len

CRM114_ERR
crm114_vector_tokenize(txtptr, txtstart, txtlen, p_cb, frs, frslen, frs_out, next_offset)
	const char *	txtptr
	long	txtstart
	long	txtlen
	const CRM114_CONTROLBLOCK *	p_cb
	struct crm114_feature_row	frs[]
	long	frslen
	long *	frs_out
	long *	next_offset

char *
ctermid(arg0)
	char *	arg0

char *
ctermid_r(arg0)
	char *	arg0

int
fclose(arg0)
	FILE *	arg0

void
fcloseall()

FILE *
fdopen(arg0, arg1)
	int	arg0
	const char *	arg1

int
feof(arg0)
	FILE *	arg0

int
feof_unlocked(arg0)
	FILE *	arg0

int
ferror(arg0)
	FILE *	arg0

int
ferror_unlocked(arg0)
	FILE *	arg0

int
fflush(arg0)
	FILE *	arg0

int
fgetc(arg0)
	FILE *	arg0

char *
fgetln(arg0, arg1)
	FILE *	arg0
	size_t *	arg1

int
fgetpos(arg0, arg1)
	FILE *	arg0
	fpos_t *	arg1

char *
fgets(arg0, arg1, arg2)
	char *	arg0
	int	arg1
	FILE *	arg2

int
fileno(arg0)
	FILE *	arg0

int
fileno_unlocked(arg0)
	FILE *	arg0

void
flockfile(arg0)
	FILE *	arg0

const char *
fmtcheck(arg0, arg1)
	const char *	arg0
	const char *	arg1

FILE *
fopen(arg0, arg1)
	const char *	arg0
	const char *	arg1

int
fprintf(arg0, arg1, ...)
	FILE *	arg0
	const char *	arg1

int
fpurge(arg0)
	FILE *	arg0

int
fputc(arg0, arg1)
	int	arg0
	FILE *	arg1

int
fputs(arg0, arg1)
	const char *	arg0
	FILE *	arg1

size_t
fread(arg0, arg1, arg2, arg3)
	void *	arg0
	size_t	arg1
	size_t	arg2
	FILE *	arg3

FILE *
freopen(arg0, arg1, arg2)
	const char *	arg0
	const char *	arg1
	FILE *	arg2

int
fscanf(arg0, arg1, ...)
	FILE *	arg0
	const char *	arg1

int
fseek(arg0, arg1, arg2)
	FILE *	arg0
	long	arg1
	int	arg2

int
fseeko(arg0, arg1, arg2)
	FILE *	arg0
	__off_t	arg1
	int	arg2

int
fsetpos(arg0, arg1)
	FILE *	arg0
	const fpos_t *	arg1

long
ftell(arg0)
	FILE *	arg0

__off_t
ftello(arg0)
	FILE *	arg0

int
ftruncate(arg0, arg1)
	int	arg0
	__off_t	arg1

int
ftrylockfile(arg0)
	FILE *	arg0

void
funlockfile(arg0)
	FILE *	arg0

FILE *
funopen(arg0, arg1, arg2, arg3, arg4)
	const void *	arg0
	int ( * ) ( void *, char *, int )	arg1
	int ( * ) ( void *, const char *, int )	arg2
	fpos_t ( * ) ( void *, fpos_t, int )	arg3
	int ( * ) ( void * )	arg4

size_t
fwrite(arg0, arg1, arg2, arg3)
	const void *	arg0
	size_t	arg1
	size_t	arg2
	FILE *	arg3

int
getc(arg0)
	FILE *	arg0

int
getc_unlocked(arg0)
	FILE *	arg0

int
getchar()

int
getchar_unlocked()

ssize_t
getdelim(arg0, arg1, arg2, arg3)
	char **	arg0
	size_t *	arg1
	int	arg2
	FILE *	arg3

char *
gets(arg0)
	char *	arg0

int
getw(arg0)
	FILE *	arg0

__off_t
lseek(arg0, arg1, arg2)
	int	arg0
	__off_t	arg1
	int	arg2

void *
mmap(arg0, arg1, arg2, arg3, arg4, arg5)
	void *	arg0
	size_t	arg1
	int	arg2
	int	arg3
	int	arg4
	__off_t	arg5

int
pclose(arg0)
	FILE *	arg0

void
perror(arg0)
	const char *	arg0

FILE *
popen(arg0, arg1)
	const char *	arg0
	const char *	arg1

int
printf(arg0, ...)
	const char *	arg0

int
putc(arg0, arg1)
	int	arg0
	FILE *	arg1

int
putc_unlocked(arg0, arg1)
	int	arg0
	FILE *	arg1

int
putchar(arg0)
	int	arg0

int
putchar_unlocked(arg0)
	int	arg0

int
puts(arg0)
	const char *	arg0

int
putw(arg0, arg1)
	int	arg0
	FILE *	arg1

int
remove(arg0)
	const char *	arg0

int
rename(arg0, arg1)
	const char *	arg0
	const char *	arg1

int
renameat(arg0, arg1, arg2, arg3)
	int	arg0
	const char *	arg1
	int	arg2
	const char *	arg3

void
rewind(arg0)
	FILE *	arg0

int
scanf(arg0, ...)
	const char *	arg0

void
setbuf(arg0, arg1)
	FILE *	arg0
	char *	arg1

void
setbuffer(arg0, arg1, arg2)
	FILE *	arg0
	char *	arg1
	int	arg2

int
setlinebuf(arg0)
	FILE *	arg0

int
setvbuf(arg0, arg1, arg2, arg3)
	FILE *	arg0
	char *	arg1
	int	arg2
	size_t	arg3

int
snprintf(arg0, arg1, arg2, ...)
	char *	arg0
	size_t	arg1
	const char *	arg2

int
sprintf(arg0, arg1, ...)
	char *	arg0
	const char *	arg1

int
sscanf(arg0, arg1, ...)
	const char *	arg0
	const char *	arg1

char *
tempnam(arg0, arg1)
	const char *	arg0
	const char *	arg1

FILE *
tmpfile()

char *
tmpnam(arg0)
	char *	arg0

int
truncate(arg0, arg1)
	const char *	arg0
	__off_t	arg1

int
ungetc(arg0, arg1)
	int	arg0
	FILE *	arg1

int
vasprintf(arg0, arg1, arg2)
	char **	arg0
	const char *	arg1
	__va_list	arg2

int
vdprintf(arg0, arg1, arg2)
	int	arg0
	const char *	arg1
	__va_list	arg2

int
vfprintf(arg0, arg1, arg2)
	FILE *	arg0
	const char *	arg1
	__va_list	arg2

int
vfscanf(arg0, arg1, arg2)
	FILE *	arg0
	const char *	arg1
	__va_list	arg2

int
vprintf(arg0, arg1)
	const char *	arg0
	__va_list	arg1

int
vscanf(arg0, arg1)
	const char *	arg0
	__va_list	arg1

int
vsnprintf(arg0, arg1, arg2, arg3)
	char *	arg0
	size_t	arg1
	const char *	arg2
	__va_list	arg3

int
vsprintf(arg0, arg1, arg2)
	char *	arg0
	const char *	arg1
	__va_list	arg2

int
vsscanf(arg0, arg1, arg2)
	const char *	arg0
	const char *	arg1
	__va_list	arg2
