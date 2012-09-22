#!/usr/bin/env perl 

use lib 'lib';

use 5.14.0;

use DancerTest;
use DancerTest::Model::Plugin;

my $store = DancerTest->connect( 'plugins.db' );

# yes, it should be a while, but something
# is messing with STDIN in the store...
for my $mod ( <> ) {
    chomp $mod;
    next if $mod =~ /^\s*#/;
    $store->new_model_object('Plugin',
        name => $mod,
        verbose => 1,
    )->store;
}
