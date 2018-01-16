use strict;
use warnings;

use Test::More;

no iq;

pass 'these tests are ...';
pass 'makes slow ...';
pass 'slow ... slow ...';
pass 'yes. slow ... slow ... slow ...';

use iq;

done_testing;

