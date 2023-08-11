#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket::INET;

my $smtpPort = 25;

# Create a TCP socket to listen on the SMTP port
my $socket = IO::Socket::INET->new(
LocalPort => $smtpPort,
Type => SOCK_STREAM,
Reuse => 1,
Listen => SOMAXCONN
) or die "Failed to create socket: $!\n";

print "SMTP server started. Listening for incoming messages...\n";

while (1) {
# Accept incoming client connections
my $clientSocket = $socket->accept();

# Start a new thread to handle the client
my $clientThread = threads->create(\&handleClient, $clientSocket);
$clientThread->detach();
}

sub handleClient {
my ($clientSocket) = @_;

# Read the incoming data
my $request = '';
while (my $line = <$clientSocket>) {
$request .= $line;
last if $line =~ /^\r\n$/; # End of request
}

# Process the incoming message
print "Received message:\n$request";

# Send a response
my $response = "250 OK\r\n";
print $clientSocket $response;

# Close the client socket
close $clientSocket;
}

# This Perl code sets up a TCP socket to listen on port 25 and accepts incoming client connections. It reads the incoming SMTP message, processes it, and sends a simple response. Please note that this is a basic implementation and does not handle all aspects of the SMTP protocol. For a complete SMTP server implementation, you may want to consider using a Perl module like Net::Server::SMTP or Net::SMTP::Server.
