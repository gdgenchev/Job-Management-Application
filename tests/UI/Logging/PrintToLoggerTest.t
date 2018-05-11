#!/usr/bin/perl
package tests::UI::Logging::PrintToLoggerTest;
use strict;
use warnings;
use Test::More;
use Test::More;
use Test::Spec;
use Test::MockObject;
use UI::Logging::PrintToLogger;
use Model::Job;
my $command;
my %jobs;


$jobs{1} = Model::Job->new( "Hello world", "saying helloworld",
    'C:\MinGW\bin\helloWorld.exe' );
shared_examples_for "A logging test" => sub {
    before each => sub {
        $command = UI::Logging::PrintToLogger->new();
    };

    my $mock = Test::MockObject->new();
    $mock->mock(
        'info' => sub {
            return 1;
        },
    );

    it " should log info for adding" => sub {
        $command->printToLogger( 2, 1, $mock, \%jobs, undef );
        ok($mock);
    };
    it " should log info for editing" => sub {
        $command->printToLogger( 3, 1, $mock, \%jobs, undef );
        ok($mock);
    };
    it " should log info for deleting" => sub {
        $command->printToLogger( 4, 1, $mock, \%jobs, $jobs{1} );
        ok($mock);
    };
    it " should log info for executing" => sub {
        $command->printToLogger( 5, 1, $mock, \%jobs, undef );
        ok($mock);
    };
        it " should return undef otherwise" => sub {
                $command->printToLogger( 6, 1, $mock, \%jobs, undef );
                ok(1);
            };
};
describe "A logger" => sub {
    it_should_behave_like "A logging test";
};
runtests unless caller;
