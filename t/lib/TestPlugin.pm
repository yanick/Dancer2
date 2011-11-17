package t::lib::TestPlugin;

use strict;
use warnings;

use Dancer;
use Dancer::Plugin;

register some_plugin_keyword => sub {
    42;
};

register wrap_request_env => sub {
    request->env;
};

register_plugin;
1;
