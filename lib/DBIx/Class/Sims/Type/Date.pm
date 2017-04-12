# vim: set sw=2 ft=perl:
package DBIx::Class::Sims::Type::Date;

use 5.010_001;

use strictures 2;

use DBIx::Class::Sims;
DBIx::Class::Sims->set_sim_types({
  map { $_ => __PACKAGE__->can($_) } qw(
    date time datetime
  )
});

use DateTime::Event::Random;

sub date {
  my ($info, $sim_spec, $runner) = @_;

  # Include 1900-01-01T00:00:00 to just before 2100-01-01T00:00:00
  my $default_span = DateTime::Span->new(
    start => DateTime->new(
      year => 1900, month => 1, day => 1,
    ),
    before => DateTime->new(
      year => 2100, month => 1, day => 1,
    ),
  );

  my $dt = DateTime::Event::Random->datetime(span => $default_span);
  return $runner->datetime_parser->format_date($dt);
}

sub time {
  my ($info, $sim_spec, $runner) = @_;

  my $dt = DateTime->new(
    # The year/month/day aren't important because we're discarding them below.
    year => 2001, month => 1, day => 1,
    hour   => int(rand(24)), # 0 is acceptable. 24 is not
    minute => int(rand(60)), # 0 is acceptable. 60 is not
    second => int(rand(60)), # 0 is acceptable. 60 is not
  );
  return $runner->datetime_parser->format_time($dt);
}

sub datetime {
  my ($info, $sim_spec, $runner) = @_;

  my $dt = DateTime::Event::Random->datetime;
  return $runner->datetime_parser->format_datetime($dt);
}

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

=item * date

This generates a date correctly formatted for the RDBMS being used.

=over 4

=item * Foo

=back

=item * time

This generates a time correctly formatted for the RDBMS being used.

=item * us_address

This generates a reasonable-looking US street address. The address will be one
of these forms:

=head1 AUTHOR

Rob Kinyon <rob.kinyon@gmail.com>

=head1 LICENSE

Copyright (c) 2017 Rob Kinyon. All Rights Reserved.
This is free software, you may use it and distribute it under the same terms
as Perl itself.

=cut
