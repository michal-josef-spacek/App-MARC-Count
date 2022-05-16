use strict;
use warnings;

use App::MARC::Count;
use English;
use File::Object;
use File::Spec::Functions qw(abs2rel);
use Test::More 'tests' => 3;
use Test::NoWarnings;
use Test::Output;

my $data_dir = File::Object->new->up->dir('data');
my $script = abs2rel(File::Object->new->file('04-run.t')->s);
# XXX Hack for missing abs2rel on Windows.
if ($OSNAME eq 'MSWin32') {
	$script =~ s/\\/\//msg;
}

# Test.
@ARGV = (
	'-h',
);
my $right_ret = <<"END";
Usage: $script [-h] [--version] marc_xml_file
	-h		Print help.
	--version	Print version.
	marc_xml_file	MARC XML file.
END
stderr_is(
	sub {
		App::MARC::Count->new->run;
		return;
	},
	$right_ret,
	'Run help.',
);

# Test.
@ARGV = (
	$data_dir->file('ex1.xml')->s,
);
stdout_is(
	sub {
		App::MARC::Count->new->run;
		return;
	},
	"3\n",
	'Run count for MARC XML file with 3 records.',
);
