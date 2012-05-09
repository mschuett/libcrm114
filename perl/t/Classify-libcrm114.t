# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Classify-libcrm114.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 26;
BEGIN { use_ok('Classify::libcrm114') };
use lib "t";
BEGIN { use_ok('SampleText') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

# check some constants
is(Classify::libcrm114::MARKOVIAN,  1<<21);
is(Classify::libcrm114::OSB,        1<<22);
is(Classify::libcrm114::WINNOW,     1<<24);
is(Classify::libcrm114::OSBF,       1<<28);
is(Classify::libcrm114::HYPERSPACE, 1<<29);
is(Classify::libcrm114::SVM,        1<<35);

# enum
ok(defined(Classify::libcrm114::OK));
ok(defined(Classify::libcrm114::UNK));
ok(defined(Classify::libcrm114::NOMEM));
# one should not rely on enum value, but some code might still rely on it
is(Classify::libcrm114::OK, 0);
is(0, Classify::libcrm114::OK);

# test low-level interface, especially memory mallloc/realloc/free
my $cb = Classify::libcrm114::new_cb();
ok(defined($cb));
ok($cb);

Classify::libcrm114::cb_setflags($cb, Classify::libcrm114::HYPERSPACE);
Classify::libcrm114::cb_setclassdefaults($cb);
Classify::libcrm114::cb_setdatablock_size($cb, 25200);
Classify::libcrm114::cb_setblockdefaults($cb);
Classify::libcrm114::cb_setclassname($cb, 0, 'A');
Classify::libcrm114::cb_setclassname($cb, 1, 'B');
my $db = Classify::libcrm114::new_db($cb);
ok($db);
my ($size, $addr) = Classify::libcrm114::db_getinfo($db);
my $original_addr = $addr;
is($size, 25200);

my ($err, $class, $prob, $pR, $unk);
$err = Classify::libcrm114::learn_text($db, 0, SampleText::Alice(), length(SampleText::Alice()));
is($err, Classify::libcrm114::OK);
$err = Classify::libcrm114::learn_text($db, 1, SampleText::Macbeth(), length(SampleText::Macbeth()));
is($err, Classify::libcrm114::OK);
# check successful resize
($size, $addr) = Classify::libcrm114::db_getinfo($db);
ok($original_addr != $addr);
ok($size > 25200);

($err, $class, $prob, $pR, $unk) = Classify::libcrm114::classify($db, SampleText::Hound_frag(), length(SampleText::Hound_frag()));
is($err, Classify::libcrm114::OK);
is($class, "B");
is(sprintf("%.3f", $prob), "0.458");
is(sprintf("%.6f", $pR), "-0.073242");
is($unk, 180);

