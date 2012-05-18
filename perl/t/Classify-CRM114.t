use strict;
use warnings;

use Test::More tests => 55;
BEGIN { use_ok('Classify::CRM114') };
use lib 't';
BEGIN { use_ok('SampleText') };

can_ok('Classify::CRM114', qw(new readfile));
my $db = Classify::CRM114->new();
isa_ok($db, 'Classify::CRM114');
can_ok($db, qw(learn classify writefile));

$db = Classify::CRM114->new(Classify::CRM114::OSB, 8000000, ["Alice", "Macbeth"]);
isa_ok($db, 'Classify::CRM114');

$db->learn("Alice", SampleText::Alice());
$db->learn("Macbeth", SampleText::Macbeth());

my $filename = "/tmp/sample.db";
my $rc = $db->writefile($filename);
is($rc, Classify::CRM114::OK, "writefile");
is(Classify::libcrm114::strerror($rc), "success");
undef $db;

# read anew from file 
$db = Classify::CRM114->readfile($filename);
isa_ok($db, 'Classify::CRM114');

my %classes = %{$db->getclasses()};
isa_ok(\%classes, 'HASH', "getclasses()");
ok(defined($classes{"Alice"}));
ok(defined($classes{"Macbeth"}));
is($classes{"Alice"}, 0);
is($classes{"Macbeth"}, 1);
is(scalar(keys(%classes)), 2);

# result values from simple_demo.c

# "normal mode" -- adjusted values
my($err, $errmsg, $class, $prob, $pR) = $db->classify(SampleText::Alice_frag());
is($err, Classify::CRM114::OK);
is($errmsg, "success");
is($class, "Alice");
is(sprintf("%.1f", $prob), "1.0");
is(sprintf("%.6f", $pR), "19.779991");

($err, $errmsg, $class, $prob, $pR) = $db->classify(SampleText::Macbeth_frag());
is($err, Classify::CRM114::OK);
is($errmsg, "success");
is($class, "Macbeth");
is(sprintf("%.1f", $prob), "1.0");
is(sprintf("%.6f", $pR), "20.351904");

($err, $errmsg, $class, $prob, $pR) = $db->classify(SampleText::Hound_frag());
is($err, Classify::CRM114::OK);
is($errmsg, "success");
is($class, "Macbeth");
is(sprintf("%.3f", $prob), "0.596");
is(sprintf("%.6f", $pR), "0.169050");

($err, $errmsg, $class, $prob, $pR) = $db->classify(SampleText::Willows_frag());
is($err, Classify::CRM114::OK);
is($errmsg, "success");
is($class, "Alice");
is(sprintf("%.3f", $prob), "0.897");
is(sprintf("%.6f", $pR), "0.938232");

# "verbatim mode"
($err, $errmsg, $class, $prob, $pR) = $db->classify(SampleText::Alice_frag(), 1);
is($err, Classify::CRM114::OK);
is($errmsg, "success");
is($class, "Alice");
is(sprintf("%.1f", $prob), "1.0");
is(sprintf("%.6f", $pR), "19.779991");

($err, $errmsg, $class, $prob, $pR) = $db->classify(SampleText::Macbeth_frag(), 1);
is($err, Classify::CRM114::OK);
is($errmsg, "success");
is($class, "Macbeth");
is(sprintf("%.1f", $prob), "0.0");
is(sprintf("%.6f", $pR), "-20.351904");

($err, $errmsg, $class, $prob, $pR) = $db->classify(SampleText::Hound_frag(), 1);
is($err, Classify::CRM114::OK);
is($errmsg, "success");
is($class, "Macbeth");
is(sprintf("%.3f", $prob), "0.404");
is(sprintf("%.6f", $pR), "-0.169050");

($err, $errmsg, $class, $prob, $pR) = $db->classify(SampleText::Willows_frag(), 1);
is($err, Classify::CRM114::OK);
is($errmsg, "success");
is($class, "Alice");
is(sprintf("%.3f", $prob), "0.897");
is(sprintf("%.6f", $pR), "0.938232");
