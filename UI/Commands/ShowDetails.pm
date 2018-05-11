package UI::Commands::ShowDetails;
use parent 'UI::Menu';
use parent 'ChangedJobObserver::ChangedJobByCommand';
use strict;
use warnings FATAL => 'all';
use Model::Job;

sub new {
    my $class = shift;
    my $self  = {};
    bless( $self, $class );
    return $self;
}

sub execute {
    my ( $self, $filename, $jobsref ) = @_;
    my %jobs = %{$jobsref};
    if ( !%jobs ) {
        print "No jobs found\nReturning to main menu...\n";
        return %jobs;
    }
    foreach my $id ( sort { $a <=> $b } keys %jobs ) {
        print $id . "." . $jobs{$id}->printToConsole . "\n";
    }
    return %jobs;
}
1;
