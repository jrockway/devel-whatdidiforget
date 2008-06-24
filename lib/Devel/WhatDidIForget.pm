package Devel::WhatDidIForget;
use strict;
use warnings;

sub DB::DB { die "You didn't forget anything." };

my @forgotten;

BEGIN {
    push @INC, sub {
        my $mod = $_[1];
        $mod =~ s/[.]pm$//g;
        $mod =~ s/\W/::/g;

        push @forgotten, $mod;

        my $first = 1;
        return sub { 
            do { $_ = "1" } and return 1 if $first--; 
            return 0;
        };
    };
}

CHECK {
    die "You are missing: ", join ', ', @forgotten if @forgotten;
}

1;

=head1 NAME

Devel::WhatDidIForget - what modules did I forget to install?

=head1 SYNOPSIS

  perl -d:WhatDidIForget some_script.pl

=head1 DESCRIPTION

Sometimes you forget to declare your prerequisites and have to
painfully run your program multiple times, watch it print C<<Can't
locate Foo.pm in @INC (@INC contains ...)>>, install that module, and
repeat until you have everything installed.  That is tedious and time
consuming.  You can't even paste the module in the error message into
the CPAN shell; you have to translate C</>s to C<::>s.

This module can help.  It will catch all the uninstalled modules,
print them (in pastable form), and then exit.

=cut

__DATA__
1;
