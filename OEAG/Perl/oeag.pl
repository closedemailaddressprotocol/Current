#!/usr/bin/perl

use warnings;
use strict;
use Crypt::Digest::SHA256 qw( sha256_b64);

my $sha_256_b64 = sha256_b64($ARGV[0]);

$sha_256_b64 =~ s/[^A-Za-z0-9]//g;

print($sha_256_b64);

1;

#use Digest::SHA qw(hmac_sha256_hex); 
#$digest=hmac_sha256_hex($all, $secret);


