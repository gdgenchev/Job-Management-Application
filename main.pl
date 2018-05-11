#!/usr/bin/perl
use strict;
use warnings;
use lib 'C:\Users\C5262029\Documents\Job-Management-Application';
use Persistence::PersistenceServiceFactory;
use Persistence::PersistenceService;
use UI::MenuFactory;
use UI::Menu;


sub main {

    my $filename = $ENV{HOME} . '\jobs.csv';    #HOME by default
    my $persistenceFactory =
      Persistence::PersistenceServiceFactory->getFactory();
    my $persistenceService  = $persistenceFactory->getPersistenceService($filename);
    my %jobs  = $persistenceService->read();
    my $input = "";
    print
"Available commands:\n1.show details\n2.add new\n3.edit\n4.delete\n5.execute\n6.exit\n";
    while ( 1 ) {
        chomp( $input = <STDIN> );
        if($input eq "6") {
            last;
        }
        my $menuFactory = UI::MenuFactory->getFactory();
        my $menu        = $menuFactory->createMenu($filename, $input,$persistenceService);
        if ( defined $menu ) {
            %jobs = $menu->execute( $filename, \%jobs );
        }
        else {
            print "Enter valid number!\n";
        }
    }
}

main();
