#!/usr/bin/perl
package tests::AllTests;

use strict;
use warnings;
use Test::Spec;

spec_helper "UI/MenuFactoryTest.t";
spec_helper "UI/Commands/AddTest.t";
spec_helper "UI/Commands/EditTest.t";
spec_helper "UI/Commands/DeleteTest.t";
spec_helper "UI/Commands/ExecuteTest.t";
spec_helper "ChangedJobObserver/ChangedJobByCommandTest.t";
spec_helper "UI/Logging/PrintToLoggerTest.t";
spec_helper "UI/Commands/ShowDetailsTest.t";

# include all relevant for the app tests
describe "A MenuFactory" => sub {
    it_should_behave_like "A Job Command MenuFactory";
};
describe "An Add Command" => sub {
    it_should_behave_like "An Add Command execution";
};
describe "An Edit Command" => sub {
    it_should_behave_like "An Edit Command execution";
};
describe "A Delete Command" => sub {
    it_should_behave_like "A Delete Command execution";
};
describe "An Execution Command" => sub {
    it_should_behave_like "An Execution Command execution";
};
describe "A ChangedJobByCommand Obserber" => sub {
    it_should_behave_like "A ChangedJobByCommand observer";
};
describe "Logging test" => sub {
    it_should_behave_like "A logging test";
};
describe "Show Details Command" => sub {
    it_should_behave_like "Show Details Command execution";
};
runtests unless caller;
