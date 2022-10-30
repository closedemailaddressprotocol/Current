#!/usr/bin/perl
print "Using Digest::SHA qw(sha256) :\n";
use Digest::SHA qw(sha256);
print unpack("H*", sha256('VERIFY_SHA256')), "\n";
print unpack("H*", sha256('_VERIFY_SHA256_')), "\n\n";

print "Using Digest::SHA qw(sha256_hex) :\n";
use Digest::SHA qw(sha256_hex);
print sha256_hex('VERIFY_SHA256'), "\n";
print sha256_hex('_VERIFY_SHA256_'), "\n\n";

