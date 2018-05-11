#!/usr/bin/perl
package tests::UI::Commands::EditTest;
use strict;
use warnings;
use Test::Spec;
use UI::Commands::Edit;
my $command;
my %jobs;
$jobs{1}->{name}        = "Hello world";
$jobs{1}->{description} = "saying hello world";
$jobs{1}->{path}        = "random path";
shared_examples_for "An Edit Command execution" => sub {
    before each => sub {
        $command = UI::Commands::Edit->new();
    };
    it "should edit job by id" => sub {
            $command->stubs(
                readInput => sub {
                    my ( $self, $jobsref ) = @_;
                    $self->{id} = 1;
                    $self->{name} = "Edited Name";
                    $self->{description} = "Edited Description";
                    $self->{path}= "Edited Path";
                    return 1;
                }
            );

        %jobs = $command->execute( undef, \%jobs );
        ok(      $jobs{1}->{name} eq "Edited Name"
              && $jobs{1}->{description} eq "Edited Description"
              && $jobs{1}->{path} eq "Edited Path" );

      };
        it "should do nothing if undef" => sub {
                my %jobsEmpty;
                %jobs = $command->execute( undef, \%jobsEmpty );
                ok(1);
            };

        it "should do nothing if undef job id" => sub {
                $command->stubs(
                    readInput => sub {
                        my ( $self, $jobsref ) = @_;
                        $self->{id} = 2;
                        $self->{name} = "Edited Name";
                        $self->{description} = "Edited Description";
                        $self->{path}= "Edited Path";
                        return 0;
                    }
                );
                   ok($command->readInput(\%jobs) == 0);
            };
};
describe "An Edit command" => sub {
    it_should_behave_like "An Edit Command execution";
};
runtests unless caller;
