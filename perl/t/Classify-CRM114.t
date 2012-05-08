use strict;
use warnings;

use Test::More tests => 36;
BEGIN { use_ok('Classify::CRM114') };
use lib 't';
BEGIN { use_ok('SampleText') };

my $db = Classify::CRM114->new();
ok(defined $db);

# TODO: copy constants into Classify::CRM114 namespace?
$db = Classify::CRM114->new(Classify::libcrm114::OSB, 8000000, ["Alice", "Macbeth"]);
ok(defined $db);

$db->learn("Alice", SampleText::Alice());
$db->learn("Macbeth", SampleText::Macbeth());

my $filename = "/tmp/sample.db";
my $rc = $db->writefile($filename);
is($rc, Classify::libcrm114::OK);
is(Classify::libcrm114::strerror($rc), "success");

undef $db;

$db = Classify::CRM114->readfile($filename);

my %classes = %{$db->getclasses()};
ok(%classes);
ok(defined($classes{"Alice"}));
ok(defined($classes{"Macbeth"}));
is($classes{"Alice"}, 0);
is($classes{"Macbeth"}, 1);
is(scalar(keys(%classes)), 2);

# result values from simple_demo.c
my ($err, $errmsg, $class, $prob, $pR, $unk) = $db->classify(SampleText::Alice_frag());
is($err, Classify::libcrm114::OK);
is($errmsg, "success");
is($class, "Alice");
is(sprintf("%.1f", $prob), "1.0");
is(sprintf("%.6f", $pR), "19.779991");
is($unk, 220);

($err, $errmsg, $class, $prob, $pR, $unk) = $db->classify(SampleText::Macbeth_frag());
is($err, Classify::libcrm114::OK);
is($errmsg, "success");
is($class, "Macbeth");
is(sprintf("%.1f", $prob), "0.0");
is(sprintf("%.6f", $pR), "-20.351904");
is($unk, 236);

($err, $errmsg, $class, $prob, $pR, $unk) = $db->classify(SampleText::Hound_frag());
is($err, Classify::libcrm114::OK);
is($errmsg, "success");
is($class, "Macbeth");
is(sprintf("%.3f", $prob), "0.404");
is(sprintf("%.6f", $pR), "-0.169050");
is($unk, 180);

($err, $errmsg, $class, $prob, $pR, $unk) = $db->classify(SampleText::Willows_frag());
is($err, Classify::libcrm114::OK);
is($errmsg, "success");
is($class, "Alice");
is(sprintf("%.3f", $prob), "0.897");
is(sprintf("%.6f", $pR), "0.938232");
is($unk, 208);

