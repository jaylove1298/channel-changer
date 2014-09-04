#!/usr/bin/perl

# Updated to handle arbitrary channel lengths, Robert Kulagowski, 2011-07-18

use Getopt::Std;

# make sure to set the remote_name string to
# the corresponding remote in /etc/lircd.conf
$remote_name = "blaster";

$key_prefix = "0_82_KEY_";

use constant false => 0;
use constant true  => 1;

my $debugenabled = false;

my %options = ();
getopts( "dh", \%options );

if ( $options{h} ) {
    print "usage: channelChanger.pl [-d] [-h] channum\n\n";
    print "Parameter              Meaning\n";
    print "-d                     enable debug mode\n";
    print "-h                     help (this screen)\n";
    print "channum                Integer channel number.  Must be last parameter.\n";
    exit(1);
}

if ( $options{d} ) { $debugenabled = true; }

my $channel = $ARGV[scalar(@ARGV)-1];

if ($debugenabled) { print "channel is $channel\n"; }

sleep 1;
for ($i = 0; $i < length($channel); $i++)
{
    change_channel(substr($channel,$i,1));
}

# In the next command, check the /etc/lirc/lircd.conf file and confirm if
# your remote definition file uses "select" or "enter" or "ENTER" or whatever.

#system ("irsend SEND_ONCE $remote_name select");

sub change_channel {
        my($channel_digit) = @_;
        if ($debugenabled) { print "Sending $channel_digit\n"; }
        system ("irsend SEND_ONCE $remote_name $key_prefix$channel_digit;sleep 1;");
        #sleep 1;
}
