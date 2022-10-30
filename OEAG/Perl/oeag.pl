#!/usr/bin/perl

use warnings;
use strict;
use Crypt::Digest::SHA256 qw( sha256 sha256_hex sha256_b64 sha256_b64u
                             sha256_file sha256_file_hex sha256_file_b64 sha256_file_b64u );

my $secret = $ARGV[0];

my $digest=unpack("H*", sha256_hex(256, $secret));

print($digest);


