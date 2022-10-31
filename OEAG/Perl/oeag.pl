#!/usr/bin/perl

use Digest::SHA qw(sha256);

my $auth   = $ARGV[0];

$auth=~s/\R//g;

if ( $auth eq "") {
	print "usage: oeag <authorization phrase>\n";
	exit 1;
}


my $sha64=unpack("H*", sha256($auth));

$sha64=~s/[^A-Za-z0-9]//g;

print $sha64;

1;
