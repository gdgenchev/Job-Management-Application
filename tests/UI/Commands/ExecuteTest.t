#!/usr/bin/perl
package tests::UI::Commands::ExecuteTest;
use strict;
use warnings;
use Test::More;
use Test::Spec;
use Test::MockObject;
use UI::Commands::Execute;
my $command;
my %jobs;
$jobs{1}->{name}        = "Hello world";
$jobs{1}->{description} = "saying hello world";
$jobs{1}->{path}        = 'C:\MinGW\bin\helloWorld.exe';
$jobs{2}->{name}        = "ping";
$jobs{2}->{description} = "getting the ping";
$jobs{2}->{path}        = 'ping 8.8.8.8';
my %jobs1;
$jobs1{1}->{name}        = "Hello world";
$jobs1{1}->{description} = "saying hello world";
$jobs1{1}->{path}        = 'C:\MinGW\bin\helloWorld.exe';
my %jobs2;
$jobs2{1}->{name}        = "ping";
$jobs2{1}->{description} = "getting the ping";
$jobs2{1}->{path}        = 'ping 8.8.8.8';
shared_examples_for "An Execution Command execution" => sub {
    before each => sub {
        $command = UI::Commands::Execute->new();
    };

    it "should create a job" => sub {
            $command->stubs(
                readInput => sub {
                    my ($self) = @_;
                    $self->{id}      = 1;
                    $self->{hours}   = 0;
                    $self->{minutes} = 0;
                    $self->{seconds} = 0;
                    return 1;
                }
            );
        my $mock = Test::MockObject->new();
        $mock->fake_module(
            'Forks::Super',
            fork => sub {
                return 1;
            }
        );
        $command->expects('readCommand')->once()->returns(1);
        $command->execute( undef, \%jobs );
        is( $command->{_pid}, 1 );
    };
    it "should suspend a job if entered command is 1" => sub {
        my $job = mock();
        $command->{_pid} = $job;
        $job->expects('suspend')->once();
        $command->manage( 1, \%jobs );
        ok(1);

    };
    it "should resume a job if entered command is 2" => sub {
        my $job = mock();
        $command->{_pid} = $job;
        $job->expects('resume')->once();
        $command->manage( 2, \%jobs );
        ok(1);
    };

    it "should kill a job if entered command is 3 and the job is .exe" => sub {
        my $job = mock();
        $command->{_pid} = $job;
         $job->expects('kill')->once();
        $command->expects("isExe")->once()->returns(1);
        $command->manage( 3, \%jobs );
        ok(1);
    };

        it "should kill a job if entered command is 3 and the job is not .exe" => sub {
                my $job = mock();
                $command->{_pid} = $job;
                $job->expects('kill')->once();
                $command->expects("isExe")->once()->returns(0);
                $command->manage( 3, \%jobs );
                ok(1);
            };

        it "should do nothing if there are no jobs"=>sub {
                my %jobsEmpty;
                %jobs = $command->execute( undef, \%jobsEmpty );
                ok(1);

            };

        it "should return 1 if the job is .exe" => sub{
            ok($command->isExe(\%jobs1));
        };

        it "should return 0 if the job is not .exe" => sub{
                ok(!$command->isExe(\%jobs2));
            };
};

describe "An Execution Command" => sub {
    it_should_behave_like "An Execution Command execution";
};
runtests unless caller;

