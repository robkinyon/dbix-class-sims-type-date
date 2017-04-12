# vi:sw=2
use strictures 2;

use Test::More;

BEGIN {
  use t::loader qw(build_schema);
  build_schema();
}

use t::common qw(Schema);

use_ok 'DBIx::Class::Sims::Type::Date';

my $sub = DBIx::Class::Sims::Type::Date->can('timestamp');

my $runner = DBIx::Class::Sims::Runner->new(
  parent => undef,
  schema => Schema,
  toposort => undef,
  initial_spec => undef,
  spec => undef,
  hooks => undef,
  reqs => undef,
);

my $value = $sub->({}, { type => 'timestamp' }, $runner);
like($value, qr/^\d{4}-\d{2}-\d{2} (?:[01]\d|2[0-3]):[0-5]\d:[0-5]\d$/, "'$value' is a legal timestamp");

done_testing;

