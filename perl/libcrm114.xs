#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <crm114_config.h>
#include <crm114_structs.h>
#include <crm114_lib.h>

#include "const-c.inc"

MODULE = Classify::libcrm114		PACKAGE = Classify::libcrm114		PREFIX = crm114_

INCLUDE: const-xs.inc

PROTOTYPES: ENABLE

BOOT:
{
    HV *stash;
    stash = gv_stashpv("Classify::libcrm114", TRUE);
    newCONSTSUB(stash, "OK",          newSViv(CRM114_OK));
    newCONSTSUB(stash, "UNK",         newSViv(CRM114_UNK));
    newCONSTSUB(stash, "BADARG",      newSViv(CRM114_BADARG));
    newCONSTSUB(stash, "NOMEM",       newSViv(CRM114_NOMEM));
    newCONSTSUB(stash, "REGEX_ERR",   newSViv(CRM114_REGEX_ERR));
    newCONSTSUB(stash, "FULL",        newSViv(CRM114_FULL));
    newCONSTSUB(stash, "CLASS_FULL",  newSViv(CRM114_CLASS_FULL));
    newCONSTSUB(stash, "OPEN_FAILED", newSViv(CRM114_OPEN_FAILED));
    newCONSTSUB(stash, "NOT_YET_IMPLEMENTED",   newSViv(CRM114_NOT_YET_IMPLEMENTED));
    newCONSTSUB(stash, "FROMSTART",   newSViv(CRM114_FROMSTART));
    newCONSTSUB(stash, "FROMNEXT",    newSViv(CRM114_FROMNEXT));
    newCONSTSUB(stash, "FROMEND",     newSViv(CRM114_FROMEND));
    newCONSTSUB(stash, "NEWEND",      newSViv(CRM_NEWEND));
    newCONSTSUB(stash, "FROMCURRENT", newSViv(CRM114_FROMCURRENT));
    newCONSTSUB(stash, "NOCASE",      newSViv(CRM114_NOCASE));
    newCONSTSUB(stash, "ABSENT",      newSViv(CRM114_ABSENT));
    newCONSTSUB(stash, "BASIC",       newSViv(CRM114_BASIC));
    newCONSTSUB(stash, "BACKWARDS",   newSViv(CRM114_BACKWARDS));
    newCONSTSUB(stash, "LITERAL",     newSViv(CRM114_LITERAL));
    newCONSTSUB(stash, "NOMULTILINE", newSViv(CRM114_NOMULTILINE));
    newCONSTSUB(stash, "BYCHAR",      newSViv(CRM114_BYCHAR));
    newCONSTSUB(stash, "STRING",      newSViv(CRM114_STRING));
    newCONSTSUB(stash, "APPEND",      newSViv(CRM114_APPEND));
    newCONSTSUB(stash, "REFUTE",      newSViv(CRM114_REFUTE));
    newCONSTSUB(stash, "MICROGROOM",  newSViv(CRM114_MICROGROOM));
    newCONSTSUB(stash, "MARKOVIAN",   newSViv(CRM114_MARKOVIAN));
    newCONSTSUB(stash, "OSB_BAYES",   newSViv(CRM114_OSB_BAYES));
    newCONSTSUB(stash, "OSB",         newSViv(CRM114_OSB));
    newCONSTSUB(stash, "CORRELATE",   newSViv(CRM114_CORRELATE));
    newCONSTSUB(stash, "OSB_WINNOW",  newSViv(CRM114_OSB_WINNOW));
    newCONSTSUB(stash, "WINNOW",      newSViv(CRM114_WINNOW));
    newCONSTSUB(stash, "CHI2",        newSViv(CRM114_CHI2));
    newCONSTSUB(stash, "UNIQUE",      newSViv(CRM114_UNIQUE));
    newCONSTSUB(stash, "ENTROPY",     newSViv(CRM114_ENTROPY));
    newCONSTSUB(stash, "OSBF",        newSViv(CRM114_OSBF));
    newCONSTSUB(stash, "OSBF_BAYES",  newSViv(CRM114_OSBF_BAYES));
    newCONSTSUB(stash, "HYPERSPACE",  newSViv(CRM114_HYPERSPACE));
    newCONSTSUB(stash, "UNIGRAM",     newSViv(CRM114_UNIGRAM));
    newCONSTSUB(stash, "CROSSLINK",   newSViv(CRM114_CROSSLINK));
    newCONSTSUB(stash, "READLINE",    newSViv(CRM114_READLINE));
    newCONSTSUB(stash, "DEFAULT",     newSViv(CRM114_DEFAULT));
    newCONSTSUB(stash, "SVM",         newSViv(CRM114_SVM));
    newCONSTSUB(stash, "FSCM",        newSViv(CRM114_FSCM));
    newCONSTSUB(stash, "NEURAL_NET",  newSViv(CRM114_NEURAL_NET));
    newCONSTSUB(stash, "ERASE",       newSViv(CRM114_ERASE));
    newCONSTSUB(stash, "PCA",         newSViv(CRM114_PCA));
    newCONSTSUB(stash, "BOOST",       newSViv(CRM114_BOOST));
    newCONSTSUB(stash, "FLAGS_CLASSIFIERS_MASK",  newSViv(CRM114_FLAGS_CLASSIFIERS_MASK));
}

### accessor functions for Perl

void
crm114_db_getclasses(p_db)
    CRM114_DATABLOCK *  p_db
  PREINIT:
    unsigned i = 0;
    char *name;
  PPCODE:
    /* get all classes with names */
    while (i < CRM114_MAX_CLASSES && (p_db->cb.class[i].name[0] != '\0')) {
      name = p_db->cb.class[i].name;
      XPUSHs(sv_2mortal(newSVpv(name, 0)));
      i++;
    }

void
crm114_cb_setclassname(p_cb, num, name)
    CRM114_CONTROLBLOCK * p_cb
    int num
    char * name
  CODE:
    strcpy(p_cb->class[num].name, name);
  OUTPUT:
    p_cb

void
crm114_cb_setdatablock_size(p_cb, size)
    CRM114_CONTROLBLOCK * p_cb
    size_t size
  CODE:
    p_cb->datablock_size = size;
  OUTPUT:
    p_cb

void
DESTROY(p_cb)
    void *  p_cb
  CODE:
    /* looks like ther can only be one DESTROY() function??? */
    warn("# destroying C struct @ %p\n", p_cb);
    Safefree(p_cb);

### own modifications on C level

CRM114_ERR
crm114_classify(db, text, textlen)
    CRM114_DATABLOCK *  db
    char *  text
    size_t	textlen
  PREINIT:
    CRM114_ERR err;
    CRM114_MATCHRESULT *result;
    SV *retptr;
  PPCODE:
    Newx(result, 1, CRM114_MATCHRESULT);
    warn("now calling crm114_classify_text(%p, %p, %zu, %p)\n", &db, text, textlen, result);
    err = crm114_classify_text(db, text, textlen, result);
    EXTEND(SP, 6);
    PUSHs(sv_2mortal(newSViv(err)));
    if (err == CRM114_OK) {
        PUSHs(sv_2mortal(newSVpv(db->cb.class[result->bestmatch_index].name, 0)));
        PUSHs(sv_2mortal(newSVnv(result->tsprob)));
        PUSHs(sv_2mortal(newSVnv(result->overall_pR)));
        PUSHs(sv_2mortal(newSVuv(result->unk_features)));
    } else {
        PUSHs(&PL_sv_undef);
        PUSHs(&PL_sv_undef);
        PUSHs(&PL_sv_undef);
        PUSHs(&PL_sv_undef);
    }
    Safefree(result);

### direct pass through to crm114_lib.h

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
	CRM114_CONTROLBLOCK *   p_cb

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

