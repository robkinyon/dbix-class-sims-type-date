# vi:sw=2
package # Hide from PAUSE
  t::common;

use strictures 2;

use base 'Exporter';
our @EXPORT_OK = qw(
  sims_test Schema
);

use Test::More;
use Test::Deep;
use Test::Exception;
use Test::Warn;
use Test::Trap;

use Test::DBIx::Class;

sub sims_test ($$) {
}

1;
