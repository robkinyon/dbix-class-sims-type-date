# vi:sw=2
use strictures 2;

use Test::More;

BEGIN {
  use t::loader qw(build_schema);
  build_schema();
}

use t::common qw(Schema);

use_ok 'DBIx::Class::Sims::Type::Date';

my $sub = DBIx::Class::Sims::Type::Date->can('date');

my $runner = DBIx::Class::Sims::Runner->new(
  parent => undef,
  schema => Schema,
  toposort => undef,
  initial_spec => undef,
  spec => undef,
  hooks => undef,
  reqs => undef,
);

my $value = $sub->({}, { type => 'date' }, $runner);
like($value, qr/^\d{4}-\d{2}-\d{2}$/, "'$value' is a legal date");

done_testing;
