
#!/usr/bin/perl
use CGI;
use CGI::Session;
use CGI::Cookie;
use DBI;
use DBD::mysql;
use LWP;

use strict;
use warnings;
use CGI qw(:standard);
use HTML::Template;
use JSON;

##Variables##

my $logger    =    "fucker";
my $username  =    param("username");
my $password  =    param("password");
my $setting   =    param("setting");
#my $select  =    param("myselect");
#my $selectgeneral   =    param("myselectgeneral");
my $q         =    new CGI;
my $session   =    new CGI;
my $sid       =    "";
my $cgi       =    "";
my $logout    =    param("Logout");
my $message   =    "";
#my $parameter =    "%";

## Accessing DB to grant page access ##
## MySQL driver - required to build MSSQL driver ##
## NEW SUB IMPLEMENTATION sub login {
if (defined($username)) {
    my $dbh = DBI->connect("DBI:mysql:database=unkas22;host=unkas.ckgxvc0dh42m.eu-central-1.rds.amazonaws.com;port=3306", "unkas", "wojtek29")
    or die $DBI::errstr;
    my $statement = qq{SELECT username, password from USERS where username=? and password=?};
    my $sth = $dbh->prepare($statement) or die $dbh->errstr;
    $sth->execute($username, $password) or die $sth->errstr;
## Process the form ##
        if ($sth->fetchrow_array) {
         $session = CGI::Session->new($sid);
     my $dbh = DBI->connect("DBI:mysql:database=mysql;host=localhost;port=2009", "root", "wojtek29")
         or die $DBI::errstr;
     my $template = HTML::Template->new(filename =>'newhome.tmpl');
     my $statement = qq{SELECT DateT, Results FROM DRESULTS ORDER BY DateT DESC};
     my $sth = $dbh->prepare($statement) or die $dbh->errstr;
     $sth->execute() or die $sth->errstr;
     $session->param("username", $username);
     $template->param("USER", $username);
     $logger = 1;
            my $cookie = CGI::Cookie->new(-name=>$session->name, -value=>$session->id);
            my $dumb = 1 + int rand(33);
            my $statement2 = qq{SELECT Greeting from DGREETING where ID=$dumb};
            my $sth1 = $dbh->prepare($statement2) or die $dbh->errstr;
            $sth1->execute() or die  $sth1->errstr;
            my $greeting = $sth1->fetchrow_array;
#            $session->param("greeting", $greeting);
## session setting active time ##
#            $session->expire("1h");
 #           $session->expire("~logged-in", "10m");
## fetching main  result rows for table and JSON ##
            my $rows=[];
            push @{$rows}, $_ while $_ = $sth->fetchrow_hashref();
            $message = "GENERAL TEST RESULTS";
            $template->param("MESSAGE", $message);
            $template->param("GREETING", $greeting);
            $template->param(ROWS => $rows);
            $template->param(JSROWS =>  encode_json($rows));
            print $session->header();
            print $template->output();

    } ##ending if block - if ($sth->fetchrow_array) ##
else {
my $template = HTML::Template->new(filename => 'login.tmpl');
$message = "Invalid username or password, please try again";
$template->param("MESSAGE", $message);
print $q->header(-type=> "text/html");
print $template->output();
 } ## ending else  block - logout action ##
} ## endig if block (defined($username) ##
## FOR NEW SUB IMPLEMENTATION } ## end sub login

## FOR NEW SUB IMPLEMENTATION sub results {
#    elsif (defined($myselect)) {
#         my $dbh = DBI->connect("DBI:mysql:database=mysql;host=localhost;port=2009", "root", "wojtek29")
#             or die $DBI::errstr;
#         my $statement = qq{SELECT DateT, Results FROM DRESULTS WHERE DType like $myselect . $parameter ORDER BY ID DESC};
#         my $sth = $dbh->prepare($statement) or die $dbh->errstr;
#         $sth->execute() or die $sth->errstr;
#         my $statement2 = qq{SELECT Message FROM DMESSAGE WHERE DType like $myselect};
#         my $sth2 = $dbh->prepare($statement2) or die $dbh->errstr;
#         $sth2->execute() or die $sth2->errstr;
#         $message = $sth2->fetchrow_array;
#         my $rows = [];
#         push @{$rows}, $_ while $_ = $sth->fetchrow_hashref();
#            my $template = HTML::Template->new(filename =>'newhome.tmpl');
 #        #   $message = "MORNING TEST RESULTS";
# #           $session = CGI::Session-load()or die CGI::Session->errstr;
#            my $username   = $session->username();
#            my $greeting  = $session->greeting();
#            $template->param("USER", $username);
#            $template->param("GREETING", $greeting);
#            $template->param("MESSAGE", $message);
#            $template->param(ROWS => $rows);
#            $template->param(JSROWS =>  encode_json($rows));
#            #print $q->header(-type=> "text/html");
#            print $session->header();
#            print $template->output();
#    } ## end block if defined myselect
#    elsif (defined($myselect_general)) {
#    	my $dbh = DBI->connect("DBI:mysql:database=mysql;host=localhost;port=2009", "root", "wojtek29")
#    or die $DBI::errstr;
#    my $statement = qq{SELECT DateT, Results FROM DRESULTS ORDER BY ID DESC};
#    my $sth = $dbh->prepare($statement) or die $dbh->errstr;
#    $sth->execute() or die $sth->errstr;
#    my $statement2 = qq{SELECT Message FROM DMESSAGE WHERE DType like $myselect};
#    my $sth2 = $dbh->prepare($statement2) or die $dbh->errstr;
#    $sth2->execute() or die $sth2->errstr;
#    $message = $sth2->fetchrow_array;
#    my $rows = [];
#        push @{$rows}, $_ while $_ = $sth->fetchrow_hashref();
#            my $template = HTML::Template->new(filename =>'newhome.tmpl');
# #           $session = CGI::Session-load()or die CGI::Session->errstr;
#            my $username   = $session->username();
#            my $greeting  = $session->greeting();
#         #   $message = "MORNING TEST RESULTS";
#            $template->param("USER", $username);
#            $template->param("GREETING", $greeting);
#            $template->param("MESSAGE", $message);
#            $template->param(ROWS => $rows);
#            $template->param(JSROWS =>  encode_json($rows));
#            #print $q->header(-type=> "text/html");
#            print $session->header();
#            print $template->output();
#    } ## end elsif defined myselect_general
## FOR NEW SUB IMPLEMENTATION  } end sub results
## FOR NEW SUB IMPLEMENTATION  sub logout {
#    elsif ($setting eq "Logout") {
#        $session = CGI::Session-load()or die CGI::Session->errstr;
 #       $session->delete();
  #      my $template = HTML::Template->new(filename => 'login.tmpl');
   #     my $message = "You are not logged out!";
    #    $template->param("MESSAGE", $message);
     #   print $q->header(-type=> "text/html");
      #  print $template->output();
    # } ## end block elsif ($setting eq "Logout")
## FOR NEW SUB IMPLEMENTATION  } end sub logout 
## FOR NEW SUB IMPLEMENTATION  sub empty session {
    else {
    print $q->header(-location=>'sessioncheck.pl');
} ##end else sessioncheck.pl block ##
## FOR NEW SUB IMPLEMENTATION } end sub empty session 
         
