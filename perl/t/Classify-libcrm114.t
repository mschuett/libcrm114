# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Classify-libcrm114.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 14;
BEGIN { use_ok('Classify::libcrm114') };

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

# memory alloc/free
my $cb = Classify::libcrm114::new_cb();
ok(defined($cb));
ok($cb);

