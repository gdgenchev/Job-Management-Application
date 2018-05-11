package UI::Commands::Execute;
use parent 'UI::Menu';
use parent qw(ChangedJobObserver::ChangedJobByCommand);
use strict;
use warnings FATAL => 'all';
use Forks::Super;
use Scalar::Util qw(looks_like_number);

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new();
    $self->{id}      = 1;
    $self->{hours}   = 0;
    $self->{minutes} = 0;
    $self->{seconds} = 0;
    $self->{_pid}    = undef;
    return $self;
}

sub readInput {
    my ( $self, $jobsref ) = @_;
    my %jobs = %{$jobsref};
    print "Enter id:\n";
    while (1) {
        chomp( $self->{id} = <STDIN> );
        if ( !exists $jobs{ $self->{id} } ) {
            print "Enter a valid id!\n";
        }
        else {
            last;
        }
    }
    print "Execute after\nHOURS:";
    $self->{hours} = <STDIN>;
    if ( !looks_like_number( $self->{hours} ) ) {
        $self->{hours} = 0;
    }
    print "MINUTES:";
    $self->{minutes} = <STDIN>;
    if ( !looks_like_number( $self->{minutes} ) ) {
        $self->{minutes} = 0;
    }
    print "SECONDS:";
    $self->{seconds} = <STDIN>;
    if ( !looks_like_number( $self->{seconds} ) ) {
        $self->{seconds} = 0;
    }
}

sub readCommand {
    print "Available commands:\n1.Suspend\n2.Resume\n3.Kill\n";
    my ( $self, $jobsref ) = @_;
    my %jobs = %{$jobsref};
    while (1) {
        chomp( my $input = <STDIN> );
        $self->manage( $input, $jobsref );
        if ( $input eq "3" ) {
            last;
        }
    }
    $self->notify( "5", $self->{id}, \%jobs );
}

sub manage {
    my ( $self, $input, $jobsref ) = @_;
    my %jobs = %{$jobsref};
    if ( $input eq "1" ) {
        $self->{_pid}->suspend;
    }
    if ( $input eq "2" ) {
        $self->{_pid}->resume;
    }
    if ( $input eq "3" ) {
        print "Returned to main menu.\n";
        if ( isExe( $self, $jobsref ) ) {
            $self->{_pid}->kill('TERM');
        }
        else {
            $self->{_pid}->kill('QUIT');
        }

    }
}

sub isExe {
    my ( $self, $jobsref ) = @_;
    my %jobs = %{$jobsref};
    if ( $jobs{ $self->{id} }->{path} =~ /\.exe$/ ) {
        return 1;
    }
    else {
        return 0;
    }
}

sub execute {
    my ( $self, $filename, $jobsref ) = @_;
    my %jobs = %{$jobsref};
    if ( !%jobs ) {
        print "No jobs found\nReturning to main menu...\n";
        return;
    }
    $self->readInput($jobsref);
    sleep( $self->{hours} * 3600 + $self->{minutes} * 60 + $self->{seconds} );
    $self->{_pid} = Forks::Super::fork( exec => $jobs{ $self->{id} }->{path} );
    $self->readCommand($jobsref);
    return %jobs;

}
1;
