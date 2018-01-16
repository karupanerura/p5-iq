package iq;
use 5.009005;
use strict;
use warnings;

our $VERSION = "0.01";

use Time::HiRes qw/ualarm/;

my $_ORIG_HANDLER;

sub import {
    my $class = shift;

    # skip if already imported (as default)
    return if !$^H{$class};

    # remove hinthash
    delete $^H{$class};

    # reset signal handler
    $SIG{ALRM} = sub {
        if (defined $_ORIG_HANDLER) {
            $SIG{ALRM} = $_ORIG_HANDLER;
            goto $_ORIG_HANDLER;
        }

        delete $SIG{ALRM};
    };
}

sub unimport {
    my $class = shift;

    # skip if already unimported
    return if $^H{$class};

    # set hinthash
    $^H{$class} = 'iq';

    # set signal handler
    if (defined $SIG{ALRM}) {
         $_ORIG_HANDLER = $SIG{ALRM};
        $SIG{ALRM} = sub {
            _sleep();
            goto $_ORIG_HANDLER;
        };
    } else {
        $SIG{ALRM} = \&_sleep;
    }

    # set alarm
    _sleep();
}

sub _sleep {
    sleep 1;
    ualarm 1;
}

1;
__END__

=encoding utf-8

=head1 NAME

iq - decrement IQ for your perl applciation

=head1 SYNOPSIS

    no iq;

    do_something; # it makes slowly

=head1 DESCRIPTION

iq is an Acme (joking) pragma.

=head1 LICENSE

Copyright (C) karupanerura.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

karupanerura E<lt>karupa@cpan.orgE<gt>

=cut

