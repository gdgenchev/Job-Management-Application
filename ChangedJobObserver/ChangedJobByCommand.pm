package ChangedJobObserver::ChangedJobByCommand;
use strict;
use warnings FATAL => 'all';

sub new {
    my $class = shift;
    my $self  = {};
    bless( $self, $class );
    $self->{observers} = [];
    return $self;
}

sub addObserver {
    my ( $self, $observer ) = @_;
    if ( defined $observer ) {
        push( @{ $self->{observers} }, $observer );
    }
    else {
        die "Undefined object passed";
    }
}

sub remove {
    my ( $self) = @_;
        pop @{ $self->{observers}};
}

sub notify {
    my ( $self, $action, $id, $jobsref,$deletedJob ) = @_;
    foreach my $observer ( @{ $self->{observers} } ) {
        $observer->onChangedJob( $action, $id, $jobsref, $deletedJob );
    }
}
1;
