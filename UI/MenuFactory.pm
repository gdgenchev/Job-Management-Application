package UI::MenuFactory;
use strict;
use warnings FATAL => 'all';
use UI::Logging::LoggerChangedJobObserverImpl;
use UI::Commands::Delete;
use UI::Commands::ShowDetails;
use UI::Commands::Execute;
use UI::Commands::Add;
use UI::Commands::Edit;
use UI::Commands::SaveModel;

my $instance;

sub getFactory {
    my ($class) = @_;
    if ( !defined $instance ) {
        $instance = {};
        bless( $instance, $class );
    }
    return $instance;
}

sub createMenu {
    my ( $self, $filename, $input, $persistenceService ) = @_;
    my $command;
    my $logger = UI::Logging::LoggerChangedJobObserverImpl->new();
    my $save = UI::Commands::SaveModel->new($persistenceService);

    if ( $input eq "1" ) {
        $command = UI::Commands::ShowDetails->new();
    }
    elsif ( $input eq "2" ) {
        $command = UI::Commands::Add->new();
        $command->addObserver($logger);
        $command->addObserver($save)
    }
    elsif ( $input eq "3" ) {
        $command = UI::Commands::Edit->new();
        $command->addObserver($logger);
        $command->addObserver($save)
    }
    elsif ( $input eq "4" ) {
        $command = UI::Commands::Delete->new();
        $command->addObserver($logger);
        $command->addObserver($save)
    }
    elsif ( $input eq "5" ) {
        $command = UI::Commands::Execute->new();
        $command->addObserver($logger);
    }
    else {
        return undef;
    }

    return $command;
}
1;
