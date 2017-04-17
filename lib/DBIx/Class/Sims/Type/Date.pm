# vim: set sw=2 ft=perl:
package DBIx::Class::Sims::Type::Date;

use 5.010_001;

use strictures 2;

use DBIx::Class::Sims;
DBIx::Class::Sims->set_sim_types({
  (map { $_ => __PACKAGE__->can($_) } qw(
    date time timestamp
  )),
  date_in_past => __PACKAGE__->can('date'),
  timestamp_in_past => __PACKAGE__->can('timestamp'),
});
DBIx::Class::Sims->set_sim_types([
  [ date_in_past_N_years => qr/date_in_past_\d+_years/ => __PACKAGE__->can('date') ],
  [ timestamp_in_past_N_years => qr/timestamp_in_past_\d+_years/ => __PACKAGE__->can('timestamp') ],
]);

use DateTime::Event::Random;

sub time {
  my ($info, $sim_spec, $runner) = @_;

  # We don't care about the date when generating a random time.
  my $dt = DateTime::Event::Random->datetime;
  return $runner->datetime_parser->format_time($dt);
}

sub create_span {
  # By default, include 1900-01-01T00:00:00 to just before 2100-01-01T00:00:00
  my %opts = (
    start  => DateTime->new(year => 1900, month => 1, day => 1),
    before => DateTime->new(year => 2100, month => 1, day => 1),
    @_,
  );
  return DateTime::Span->new(%opts);
}

sub _date_ish {
  my ($prefix, $formatter, $info, $sim_spec, $runner) = @_;

  my $now = DateTime->now;
  my $span;
  if ($sim_spec->{type} eq "${prefix}_in_past") {
    $span = create_span(before => $now);
  }
  elsif ($sim_spec->{type} =~ /^${prefix}_in_past_(\d+)_years$/) {
    my $duration = DateTime::Duration->new(years => $1);
    $span = create_span(
      start => $now - $duration,
      before => $now,
    );
  }
  else {
     $span = create_span();
  }

  my $dt = DateTime::Event::Random->datetime(span => $span);
  return $runner->datetime_parser->$formatter($dt);
}

# Dates and timestamps are handled identically, except for how the function used
# to format them. So, do it that way.
sub date      { return _date_ish(date      => format_date     => @_); }
sub timestamp { return _date_ish(timestamp => format_datetime => @_); }

1;
__END__

=head1 NAME

DBIx::Class::Sims::Type::Date - Additional Sims types for DBIx::Class::Sims

=head1 PURPOSE

These are additional types added to DBIx::Class::Sims which handle generation
of dates.

=head2 TYPES

The following sim types are pre-defined:

=over 4

=item * timestamp

This generates a timestamp correctly formatted for the RDBMS being used.

=item * time

This generates a time correctly formatted for the RDBMS being used.

=item * date

This generates a date correctly formatted for the RDBMS being used.

=head1 AUTHOR

Rob Kinyon <rob.kinyon@gmail.com>

=head1 LICENSE

Copyright (c) 2017 Rob Kinyon. All Rights Reserved.
This is free software, you may use it and distribute it under the same terms
as Perl itself.

=cut
