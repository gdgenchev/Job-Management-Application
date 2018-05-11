package UI::Logging::PrintToLogger;
use strict;
use warnings FATAL => 'all';
use Model::Job;

sub new {
    my ($class) = @_;
    my $self = {};
    bless( $self, $class );
    return $self;
}

sub printToLogger {
    my ( $self, $action, $id, $logger, $jobsref,$deletedJob ) = @_;
    my %jobs = %{$jobsref};
    if ( $action eq "2" ) {
        $logger->info( "Added $id." . $jobs{$id}->printToConsole );
    }
    elsif ( $action eq "3" ) {
        $logger->info( "Edited $id to " . $jobs{$id}->printToConsole );
    }
    elsif ( $action eq "4" ) {
        $logger->info( "Deleted job:$id." . $deletedJob->printToConsole );
    }
    elsif ( $action eq "5" ) {
        $logger->info( "Executed $id." . $jobs{$id}->printToConsole );
    }
    else {
        return undef;
    }
}
1;
