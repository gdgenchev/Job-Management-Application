#!/usr/bin/perl
package tests::UI::Commands::AddTest;
use strict;
use warnings;
use Test::More;
use Test::Spec;
use UI::Commands::Add;
my %jobs;
my $jobsref = \%jobs;
my $command;
shared_examples_for "An Add Command execution" => sub {

    before each => sub {
            $command = UI::Commands::Add->new();
    };
    it "should add a new job to the list" => sub {
            $command->stubs(
                readInput => sub {
                    my($self) = @_;
                    $self->{name} = 'Test';
                    $self->{description} = 'Ala bala';
                    $self->{path} = " Not defined";
                    return 1;
                }
            );

           # $command->{name} = 'Test';
          #  $command->{description} = 'Ala bala';
          #  $command->{path} = " Not defined";
           # $command->expects('readInput')->once()->returns(1);
            %jobs = $command->execute( undef,$jobsref );
            ok(defined $jobs{1} && $jobs{1}->{name} eq 'Test');
      };


};
describe "An Add command" => sub {
    it_should_behave_like "An Add Command execution";
};
runtests unless caller;
