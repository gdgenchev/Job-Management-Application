package UI::Commands::Edit;
use parent qw(UI::Menu);
use parent qw(ChangedJobObserver::ChangedJobByCommand);
use strict;
use warnings FATAL => 'all';
use Log::Log4perl qw(:easy);

sub new {
    my $class = shift;
    my $self  = {};
    bless( $self, $class );
    $self->{id}          = undef;
    $self->{name}        = undef;
    $self->{description} = undef;
    $self->{path}        = undef;
    return $self;
}

sub readInput {
    my ( $self, $jobsref ) = @_;
    my %jobs = %{$jobsref};
    print "Enter id:\n";
    while (1) {
        chomp( $self->{id} = <STDIN> );
        if ( !exists $jobs{ $self->{id} } ) {
            print "Enter a valid id\n";
        }
        else {
            last;
        }
    }
    print "Enter new name:\n";
    chomp( $self->{name} = <STDIN> );
    print "Enter new description:\n";
    chomp( $self->{description} = <STDIN> );
    print "Enter new path:\n";
    chomp( $self->{path} = <STDIN> );
}

sub execute {
    my ( $self, $filename, $jobsref ) = @_;
+    my %jobs = %{$jobsref};
    if ( !%jobs ) {
        print "No jobs found\nReturning to main menu...\n";
        return ;
    }
    $self->readInput($jobsref);
    $jobs{ $self->{id} }->{name}        = $self->{name};
    $jobs{ $self->{id} }->{description} = $self->{description};
    $jobs{ $self->{id} }->{path}        = $self->{path};
    print "Editing finished\n";
    print "Returned to main menu\n";
    $self->notify( "3", $self->{id}, \%jobs );
    return %jobs;
}

1;
