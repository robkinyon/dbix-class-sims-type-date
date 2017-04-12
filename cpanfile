requires 'DBIx::Class::Sims' => '0.300600';
requires 'DateTime::Event::Random' => '0.000001';
requires 'Data::Printer' => '0.36'; # np() isn't exported before 0.36+

on test => sub {
  requires 'File::Temp'        => '0.01';
  requires 'Test::DBIx::Class' => '0.01';
  requires 'Test::Exception'   => '0.21';
  requires 'Test::More'        => '0.88'; # done_testing
  requires 'Test::Deep'        => '0.01';
  requires 'Test::Warn'        => '0.01';
  requires 'Test::Trap'        => '0.3.2';
  requires 'DBD::SQLite'       => '1.40';
  requires 'Devel::Cover';
};
