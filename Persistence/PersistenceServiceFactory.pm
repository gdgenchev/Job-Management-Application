package Persistence::PersistenceServiceFactory;
use Persistence::TextFilePersistenceService;
use strict;
use warnings FATAL => 'all';
my $instance;

sub getFactory {
    my ($class) = @_;
    if ( !defined $instance ) {
        $instance = {};
        bless( $instance, $class );
    }
    return $instance;
}

sub getPersistenceService {
    my $file;
    my ( $self, $filename ) = @_;
    if ( $filename =~ /\.csv$/ || $filename =~ /\.txt$/ ) {
        $file = Persistence::TextFilePersistenceService->new($filename);
    }
}
1;
