package UI::Logging::LoggerChangedJobObserverImpl;
use parent qw(ChangedJobObserver::ChangedJobObserver);
use strict;
use warnings FATAL => 'all';
use Log::Log4perl qw(:easy);
use UI::Logging::PrintToLogger;

my $conf = q(
        log4perl.logger                    = INFO, FileApp
        log4perl.appender.FileApp          = Log::Log4perl::Appender::File
        log4perl.appender.FileApp.filename = ${HOME}\history.conf
        log4perl.appender.FileApp.layout   = PatternLayout
        log4perl.appender.FileApp.layout.ConversionPattern = %d> %m%n
    );
Log::Log4perl->init( \$conf );

sub new {
    my ($class) = @_;
    my $self = {};
    bless( $self, $class );
    $self->{logger} =
      Log::Log4perl->get_logger('UI::Commands::LoggerChangedJobObserverImpl');
    return $self;
}

sub onChangedJob {
    my ( $self, $action, $id, $jobsref,$deletedJob ) = @_;
    my $printToConsole = UI::Logging::PrintToLogger->new();
    $printToConsole->printToLogger( $action, $id, $self->{logger}, $jobsref,$deletedJob );
}
1;
