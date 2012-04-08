# who test the tester?

use strict;
use warnings;

use Test::More tests => 1;

use Dancer ':syntax';
use Dancer::Test;
use Dancer::Core::Request;

get '/foo' => sub { 'foo' };

route_exists [ GET => '/foo' ];
route_exists '/foo';
route_exists( Dancer::Core::Request->new( 
    path   => '/foo',
    method => 'GET',
) );



