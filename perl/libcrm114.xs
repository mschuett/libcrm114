#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <crm114_config.h>
#include <crm114_lib.h>

#include "const-c.inc"

MODULE = Classify::libcrm114		PACKAGE = Classify::libcrm114		PREFIX = crm114_

INCLUDE: const-xs.inc

void
crm114_cb_getdimensions(p_cb, pipe_len, pipe_iters)
	CRM114_CONTROLBLOCK *	p_cb
	int *	pipe_len
	int *	pipe_iters

CRM114_CONTROLBLOCK *
crm114_cb_read_text(filename)
	char *	filename

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
crm114_cb_setregex(p_cb, regex, regex_len)
	CRM114_CONTROLBLOCK *	p_cb
	char *	regex
	int	regex_len

CRM114_ERR
crm114_cb_write_text(cb, filename)
	CRM114_CONTROLBLOCK *	cb
	char *	filename

CRM114_ERR
crm114_cb_write_text_fp(cb, fp)
	CRM114_CONTROLBLOCK *	cb
	FILE *	fp

CRM114_ERR
crm114_classify_text(db, text, textlen, result)
	CRM114_DATABLOCK *	db
	char *	text
	long	textlen
	CRM114_MATCHRESULT *	result

int
crm114_db_close_mmap(db)
	CRM114_DATABLOCK *	db

CRM114_DATABLOCK *
crm114_db_open_mmap(filename)
	char *	filename

CRM114_DATABLOCK *
crm114_db_read_text(filename)
	char *	filename

CRM114_DATABLOCK *
crm114_db_read_text_fp(fp)
	FILE *	fp

CRM114_ERR
crm114_db_write_mmap(db, filename)
	CRM114_DATABLOCK *	db
	char *	filename

CRM114_ERR
crm114_db_write_text(db, filename)
	CRM114_DATABLOCK *	db
	char *	filename

CRM114_ERR
crm114_db_write_text_fp(db, fp)
	CRM114_DATABLOCK *	db
	FILE *	fp

void
crm114_free(p)
	void *	p

CRM114_ERR
crm114_learn_text(db, whichclass, text, textlen)
	CRM114_DATABLOCK **	db
	int	whichclass
	char *	text
	long	textlen

CRM114_CONTROLBLOCK *
crm114_new_cb()

CRM114_DATABLOCK *
crm114_new_db(p_cb)
	CRM114_CONTROLBLOCK *	p_cb

void
crm114_show_result(name, r)
	char *	name
	CRM114_MATCHRESULT *	r

void
crm114_show_result_class(r, icls)
	CRM114_MATCHRESULT *	r
	int	icls

const char *
crm114_strerror(err)
	CRM114_ERR	err

