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

my %tests = (
  timestamp => sub {},
  timestamp_in_past => sub {
    my ($value, $dt) = @_;
    cmp_ok($dt, '<', DateTime->now, "'$value' is in the past");
  },
  timestamp_in_past_5_years => sub {
    my ($value, $dt) = @_;
    my $duration = DateTime->now - $dt;
    cmp_ok($duration->years, '<=', 5, "'$value' is in the past 5 years");
  },
);

while (my ($type, $addl) = each %tests) {
  subtest $type => sub {
    my $sub = DBIx::Class::Sims->sim_type($type);

    my $value = $sub->({}, { type => $type }, $runner);

    foreach my $i ( 1 .. 1000 ) {
      my $dt = eval { $runner->datetime_parser->parse_datetime($value); };
      if ($@) {
        ok(0, "'$value' is NOT a legal timestamp: $@");
        # Don't run $addl->() because $dt isn't legal, so other tests won't pass.
      }
      else {
        ok(1, "'$value' is a legal timestamp");
        $addl->($value, $dt);
      }
    }
  };
}

done_testing;
