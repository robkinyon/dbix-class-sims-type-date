# NAME

DBIx::Class::Sims::Type::Date - Additional Sims types for DBIx::Class::Sims

# SYNOPSIS

Within your schema class:

    __PACKAGE__->load_components('Sims::Type::Date');

Within your sims declaration:

    column_name => {
      sims => { type => 'date_within_past_year' },
    }

# PURPOSE

These are additional types added to DBIx::Class::Sims which handle generation
of dates.

# DESCRIPTION

Dates are hard. This makes them easier.

# METHODS

None.

# TYPES

## date


# TODO

## ABCD

Lorem Ipso.

# BUGS/SUGGESTIONS

This module is hosted on Github at
[https://github.com/robkinyon/dbix-class-sims-type-date](https://github.com/robkinyon/dbix-class-sims-type-date). Pull requests are strongly
encouraged.

# SEE ALSO

[DBIx::Class](http://search.cpan.org/perldoc?DBIx::Class), [DBIx::Class::Sims](http://search.cpan.org/perldoc?DBIx::Class::Sims)

# AUTHOR

Rob Kinyon <rob.kinyon@gmail.com>

# LICENSE

Copyright (c) 2017 Rob Kinyon. All Rights Reserved.
This is free software, you may use it and distribute it under the same terms
as Perl itself.
