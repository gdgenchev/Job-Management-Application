package Model::Job;
use strict;
use warnings FATAL => 'all';

sub new {
    my ( $class, $name, $description, $path ) = @_;
    my $self = {};
    bless( $self, $class );
    $self->{name}        = $name;
    $self->{description} = $description;
    $self->{path}        = $path;
    return $self;
}

sub printToConsole {
    my $self = shift;
    return $self->{name} . " - " . $self->{description} . " - " . $self->{path};
}

sub printToFile {
    my $self = shift;
    return $self->{name} . "," . $self->{description} . "," . $self->{path};
}
1;
