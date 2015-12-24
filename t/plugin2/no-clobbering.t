use strict;
use warnings;

use Test::More;

BEGIN {
    package 
        Dancer2::Plugin::Foo;

    use Dancer2::Plugin;

    plugin_keywords 'foo', 'bar';

    sub foo :PluginKeyword {
        $_[0]->config->{oops};
    }

    sub bar :PluginKeyword {
        plugin_setting()->{oops};
    }
}

{
    package 
        Alpha;

    use Dancer2 '!pass';
    use Test::More;

    BEGIN {
        config->{plugins}{Foo}{oops} = 'alpha';
    }

    use Dancer2::Plugin::Foo;

    is foo() => 'alpha';
    is bar() => 'alpha';

}
{
    package 
        Beta;

    use Dancer2 '!pass';
    use Test::More;

    BEGIN {
        config->{plugins}{Foo}{oops} = 'beta';
    }

    use Dancer2::Plugin::Foo;

    is foo() => 'beta';
    is bar() => 'beta';
}

done_testing();
