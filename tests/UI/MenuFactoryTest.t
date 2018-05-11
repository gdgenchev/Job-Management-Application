#!/usr/bin/perl
package UI::MenuFactoryTest;
use strict;
use warnings;
use Test::Spec;
use UI::MenuFactory;
my $menuFactory;
shared_examples_for "A Job Command MenuFactory" => sub {

    before each => sub {
        $menuFactory = UI::MenuFactory->getFactory();
    };

    it " should return singleton instance" => sub {
        my $secondMEnuFactoryInstance = UI::MenuFactory->getFactory();
        ok( $menuFactory eq $secondMEnuFactoryInstance );
    };
        it "should return a Show Details command if menuItem 1 selcted" => sub {
                my $command = $menuFactory->createMenu( undef, 1 );
                my $expected = $command->isa("UI::Commands::ShowDetails");
                ok($expected);
            };
    it "should return an Add command if menuItem 2 selcted" => sub {
        my $command = $menuFactory->createMenu( undef, 2 );
        my $expected = $command->isa("UI::Commands::Add");
        ok($expected);
    };
    it "should return an Edit command if menuItem 3 selcted" => sub {
        my $command = $menuFactory->createMenu( undef, 3 );
        my $expected = $command->isa("UI::Commands::Edit");
        ok($expected);
    };
    it "should return a Delete command if menuItem 4 selcted" => sub {
        my $command = $menuFactory->createMenu( undef, 4 );
        my $expected = $command->isa("UI::Commands::Delete");
        ok($expected);
    };
    it "should return an Execute command if menuItem 5 selcted" => sub {
        my $command = $menuFactory->createMenu( undef, 5 );
        my $expected = $command->isa("UI::Commands::Execute");
        ok($expected);
    };
        it "should return undef if menuItem 6 selected" => sub {
                my $command = $menuFactory->createMenu(undef,6);
                is($command, undef);
            };
};

# Run as a separate test
describe "A MenuFactory" => sub {
    it_should_behave_like "A Job Command MenuFactory";
};
runtests unless caller;

