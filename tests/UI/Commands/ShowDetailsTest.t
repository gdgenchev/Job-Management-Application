#!/usr/bin/perl
package tests::UI::Commands::ShowDetailsTest;
use strict;
use warnings;
use Test::More;
use Test::More;
use Test::Spec;
use UI::Commands::ShowDetails;
use Model::Job;
my %jobs;
my $command;
shared_examples_for "Show Details Command execution" => sub {
        before each => sub {
                $command = UI::Commands::ShowDetails->new();
            };
        it "should return undef if there are no jobs" => sub {
                %jobs = $command->execute(undef, \%jobs);
                ok(!%jobs);
            };
        it "should return defined if there are  jobs" => sub {
                $jobs{1} = Model::Job->new("testName", "testDescription", "testPath");
               %jobs = $command->execute(undef, \%jobs);
                ok( %jobs);
            };
    };
describe "Show Details Command" => sub {
        it_should_behave_like "Show Details Command execution";
    };
runtests unless caller;

