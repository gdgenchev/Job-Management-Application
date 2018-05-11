package UI::Commands::Add;
use parent qw(ChangedJobObserver::ChangedJobByCommand);
use strict;
use warnings FATAL => 'all';
use UI::Logging::LoggerChangedJobObserverImpl;
sub new {
    my $class = shift;
    my $self  = {};
    bless( $self, $class );
    $self->{name} = undef;
    $self->{description} = undef;
    $self->{path} = undef;

    return $self;
}
sub readInput {
    my($self) = @_;
    print "Enter name:\n";
    chomp( $self->{name} = <STDIN> );
    print "Enter description:\n";
    chomp( $self->{description} = <STDIN> );
    print "Enter path:\n";
    chomp( $self->{path} = <STDIN> );
}
sub execute {
    my ( $self, $filename, $jobsref ) = @_;
    my %jobs = %{$jobsref};
    my @id_of   = keys %jobs;
    my $id = scalar @id_of;
    $self->readInput();
    $jobs{ ++$id } = Model::Job->new( $self->{name}, $self->{description}, $self->{path} );
    print "Added new job:$jobs{$id}->{name}\n";
    print "Returned to main menu...\n";
    $self->notify("2",$id,\%jobs);
    return %jobs;
}

1;
