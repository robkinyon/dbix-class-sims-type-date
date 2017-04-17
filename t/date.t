# vi:sw=2
use strictures 2;

use Test::More;

BEGIN {
  use t::loader qw(build_schema);
  build_schema();
}

use t::common qw(test_dateish);

use_ok 'DBIx::Class::Sims::Type::Date'
  or BAIL_OUT 'Cannot load DBIx::Class::Sims::Type::Date';

my %tests = (
  date => sub {},
  date_in_past => sub {
    my ($value, $dt) = @_;
    cmp_ok($dt, '<', DateTime->now, "'$value' is in the past");
  },
  date_in_past_5_years => sub {
    my ($value, $dt) = @_;
    my $duration = DateTime->now - $dt;
    cmp_ok($duration->years, '<=', 5, "'$value' is in the past 5 years");
  },
#  date_in_future => sub {
#    my ($value, $dt) = @_;
#    cmp_ok($dt, '>', DateTime->now, "'$value' is in the future");
#  },
);

while (my ($type, $addl) = each %tests) {
  test_dateish('date', 'parse_date', $type, $addl);
}

done_testing;
