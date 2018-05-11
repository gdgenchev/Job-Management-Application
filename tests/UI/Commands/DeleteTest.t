#!/usr/bin/perl
package tests::UI::Commands::Delete;
use strict;
use warnings;
use Test::More;
use Test::Spec;
use UI::Commands::Delete;
use UI::Commands::ShowDetails;
my %jobs;
$jobs{1}->{name}        = "RandomName";
$jobs{1}->{description} = "RandomDescriptnio";
$jobs{1}->{path}        = "RandomPath";
my $jobsref = \%jobs;
my $command;
shared_examples_for "A Delete Command execution" => sub {

    before each => sub {
        $command = UI::Commands::Delete->new();
    };
        it "should return undef if there are no jobs" => sub {
                my %jobsUndef;
                %jobsUndef = $command->execute(undef,\%jobsUndef);
                ok(!%jobsUndef);
            };
    it "should delete a job" => sub {
            $command->stubs(
                readInput => sub {
                    my ( $self ) = @_;
                    $self->{delete_id} = 1;
                    return 1;
                }
            );
            $command->readInput($jobsref);
            %jobs = $command->execute(undef, $jobsref);
        ok( !defined $jobs{1} );
      };

        it "should return 1 from readInput" => sub{
                $command->stubs(
                    readInput => sub {
                        my ( $self ) = @_;
                        $self->{delete_id} = 1;
                        return 1;
                    }
                );
                $command->readInput($jobsref);
                ok($command);
            };
};
describe "A Delete command" => sub {
    it_should_behave_like "A Delete Command execution";
};
runtests unless caller;

