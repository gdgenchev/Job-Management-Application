package UI::Commands::Delete;
use parent 'UI::Menu';
use parent qw(ChangedJobObserver::ChangedJobByCommand);
use strict;
use warnings FATAL => 'all';
use UI::Logging::LoggerChangedJobObserverImpl;

sub new {
    my $class = shift;
    my $self  = {};
    bless( $self, $class );
    $self->{delete_id} = undef;
    return $self;
}
sub readInput {
    my($self,$jobsref) = @_;
    my %jobs = %{$jobsref};
    print "Enter id:\n";
    while (1) {
        chomp( $self->{delete_id} = <STDIN> );
        if ( !exists $jobs{$self->{delete_id}} ) {
            print "Enter a valid id\n";
        }
        else {
            last;
        }
    }
}
sub execute {
    my ( $self, $filename, $jobsref ) = @_;
    my %jobs = %{$jobsref};
        if ( !%jobs ) {
            print "No jobs found\nReturning to main menu...\n";
            return %jobs;
        }
        $self->readInput($jobsref);
        print "Deleted job:$jobs{$self->{delete_id}}->{name}\n";
        my $deletedJob = $jobs{$self->{delete_id}};
        delete $jobs{$self->{delete_id}};
        my $flag_last = 0;
        foreach my $id ( sort { $a <=> $b } keys %jobs ) {
            if ( $self->{delete_id} == scalar %jobs + 1 ) {
                $flag_last = 1;
            }
            if ( $id > $self->{delete_id} ) {
                $jobs{ $id - 1 } = $jobs{$id};
            }

            if ( $id == scalar %jobs && $flag_last == 0 ) {
                delete $jobs{ scalar %jobs };
                last;
            }
        }
        #print "\nThe new list of jobs is:\n";
        #%jobs = UI::Commands::ShowDetails->execute( $filename, \%jobs );
        print "Returned to main menu.\n";
        $self->notify("4",$self->{delete_id},\%jobs,$deletedJob);
    return %jobs;
    }
1;
