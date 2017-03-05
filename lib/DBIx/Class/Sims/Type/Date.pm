# vim: set sw=2 ft=perl:
package DBIx::Class::Sims::Type::Date;

use 5.010_001;

use strictures 2;

use DBIx::Class::Sims;
DBIx::Class::Sims->set_sim_types({
  map { $_ => __PACKAGE__->can($_) } qw(
    date time
  )
});

sub date {
  my ($info, $runner) = @_;

  return 3;
}

sub time {
  my ($info, $runner) = @_;

  return 4;
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
