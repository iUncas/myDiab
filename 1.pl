#!/usr/bin/perl
use CGI;
#use CGI::Session;
use CGI::Cookie;
use DBD::mysql;
use LWP;

use strict;
use warnings;
use CGI qw(:standard);
use HTML::Template;
use JSON;
use DBI;
print "Content-Type: text/html\n\n";
#print "Hello World";
my $username  =    "unkas";
my $password  =    "wojtek29";
my $host = "unkas.ckgxvc0dh42m.eu-central-1.rds.amazonaws.com";
my $port = 3306;
my $dbdname = "unkas22";
 
my $dbh = DBI->connect("DBI:mysql:database=$dbdname;host=$host;port=$port", "unkas", "wojtek29")
    or die $DBI::errstr;
#my $statement = qq{SELECT username, password from USERS where username=? and password=?};
my $statement = qq(SELECT WelcomeText from mydiabprod_mydiabwelcome);
my $sth = $dbh->prepare($statement) or die $dbh->errstr;
    #$sth->execute($username, $password) or die $sth->errstr;
     $sth->execute() or die $sth->errstr;
## Process the form ##
    if ($sth->fetchrow_array) {
        #my $rows = [];
        my $x;
        while (my @results = $sth->fetchrow_array()) {
        #$sth->fetchrow_hashref();
        #my @results = $sth->fetchrow_array;
        #my $rows= $sth->fetchrow_hashref();
        #push @{$rows}, $_ while $_ = $sth->fetchrow_hashref();
        foreach my $field (@results) {
            print "welcome text: " . $field . "</br>"; 
        #print "Content-Type: text/html\n\n";          
        #print "correct username is: " . $lala;
        }
        }
        #my $printy = encode_json($rows);
        #print $printy;    
    }
$sth->finish;
