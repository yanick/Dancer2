#!/usr/bin/env perl

package DancerReport;

use 5.10.0;

use lib 'lib';

use base qw/DBIx::Class::Schema::Loader/;

my $store = DancerReport->connect('dbi:SQLite:plugins.db');

my $plugins = $store->resultset('Plugin');

my $rs = $plugins->search({
    'me.timestamp' => {
        '=' => $plugins->search(
            { 'x.name' => { '=' => { -ident => 'me.name' } } },
            { alias => 'x' }
        )->get_column('timestamp')->max_rs->as_query,
    },
});

say sprintf "%40s %10s %10s %10s", qw/ distro version dancer_1 dancer_2 /;

my $todo;

while( my $p = $rs->next ) {
    next if $p->version !~ /^\d/;
    say sprintf "%40s %10s %10s %10s", 
        map( { $p->$_ } qw/ name version / ),
        map { $_ ? 'passed' : 'failed' } map { $p->$_ } 
            qw/ dancer1_pass dancer2_pass /;

    $todo++ if $p->dancer1_pass and not $p->dancer2_pass;
}

say $todo;
