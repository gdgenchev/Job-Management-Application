package Persistence::TextFilePersistenceService;
use parent 'Persistence::PersistenceService';
use strict;
use warnings FATAL => 'all';
use Model::Job;

sub new {
    my ( $class, $filename, $jobsref ) = @_;
    my $self = {};
    bless( $self, $class );
    $self->{filename} = $filename;
    return $self;
}

sub read {
    my %jobs;
    my @data;
    my ($self) = @_;
    my $char = $ENV{CHARACTER};

    unless(-e $self->{filename}) {
        #Create the file if it doesn't exist
        open my $fc, ">", $self->{filename};
        close $fc;
    }

    open( my $fh, "<", $self->{filename} ) or die $!;
    while ( my $row = <$fh> ) {
        chomp $row;
        @data = split( $char, $row );
        $jobs{ $data[0] } = Model::Job->new( $data[1], $data[2], $data[3] );
    }
    close $fh;
    return %jobs;
}

sub save {
    my ( $self, $jobsref ) = @_;
    my %jobs  = %{$jobsref};
    my $empty = 1;
    open( my $fh, ">", $self->{filename} ) or die $!;
    foreach my $id ( sort { $a <=> $b } keys %jobs ) {
        unless ($empty) {
            print $fh "\n";
        }
        $empty = 0;
        print $fh $id . "," . $jobs{$id}->printToFile;
    }
    close $fh;
}
1;
