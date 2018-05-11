#!/usr/bin/perl
package tests::ChangedJobObserver::ChangedJobByCommand;
use strict;
use warnings;
use Test::More;
use Test::More;
use Test::Spec;
use ChangedJobObserver::ChangedJobByCommand;
my $command;
my $logger;


shared_examples_for "A ChangedJobByCommand observer" => sub {

        before each => sub {
                $command = ChangedJobObserver::ChangedJobByCommand->new();
            };
        it " should add a new observer" => sub {
                $command->addObserver(1);
                ok( defined $command->{observers} );
            };
        it " should die if observer is not defined" => sub {
                # $command->addObserver(undef);
                eval {$command->addObserver(undef);};
                my $errorMessege = $@;
                ok($errorMessege =~ /Undefined object passed.*/);
            };

        it " should remove an observer" => sub {
                @{$command->{observers}}[0] = 1;
                $command->remove;
                ok( !defined @{$command->{observers}}[0]);
            };
    };

# Run as a separate test
describe "An observer" => sub {
        it_should_behave_like "A ChangedJobByCommand observer";
    };
runtests unless caller;
