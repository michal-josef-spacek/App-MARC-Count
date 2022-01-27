use strict;
use warnings;

use App::MARC::Count;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = App::MARC::Count->new;
isa_ok($obj, 'App::MARC::Count');
