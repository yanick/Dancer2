use strict;
use warnings;

use Test::More tests => 4;

{
    package MyApp;

    use Dancer;

    set session => 'Simple';
    set logger => 'Null';
    set serializer => 'JSON';
    set template => 'Simple';

    get '/main' => sub {
        return join "\n",
               map { $_ . ' '. ( defined( engine($_)->context ) ? 1 : 0 ) }
                   qw/session logger serializer template/;
    };
}

use Dancer::Test apps => ['MyApp'];

response_content_like '/main'
    => qr/^$_ 1$/ms, "$_ has context"
    for qw/ serializer session template logger /;

