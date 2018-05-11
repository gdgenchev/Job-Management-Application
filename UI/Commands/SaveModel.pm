package UI::Commands::SaveModel;
use strict;
use warnings FATAL => 'all';
use parent 'Persistence::PersistenceService';

sub new {
    my ( $class, $persistenceService ) = @_;
    my $self = {};
    bless( $self, $class );
    $self->{persistenceService} = $persistenceService;
    return $self;
}

sub onChangedJob {
    my ( $self, $placeholer1, $placeholder2, $jobsref ) = @_;
    $self->{persistenceService}->save($jobsref);
}
1;
