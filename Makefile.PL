use inc::Module::Install;

name 'Devel-WhatDidIForget';
all_from 'lib/Devel/WhatDidIForget.pm';

build_requires 'Test::More';
build_requires 'ok';

WriteAll();
