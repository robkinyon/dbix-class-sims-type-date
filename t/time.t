# vi:sw=2
use strictures 2;

use Test::More;

BEGIN {
  use t::loader qw(build_schema);
  build_schema();
}

use t::common qw(Schema);

use_ok 'DBIx::Class::Sims::Type::Date';

my $sub = DBIx::Class::Sims::Type::Date->can('time');

my $runner = DBIx::Class::Sims::Runner->new(
  parent => undef,
  schema => Schema,
  toposort => undef,
  initial_spec => undef,
  spec => undef,
  hooks => undef,
  reqs => undef,
);

my $value = $sub->({ sim => { type => 'time' } }, { type => 'time' }, $runner);
like($value, qr/(?:[01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]/, "$value is a legal time");

done_testing;
