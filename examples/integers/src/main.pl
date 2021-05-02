use strict;
use warnings;
use 5.010;
use FFI::Platypus 1.00;

my $ffi = FFI::Platypus->new(
  api  => 1,
  lang => 'Rust',
);
$ffi->find_lib( lib => 'integers');
$ffi->attach( addition => ['u32','u32'] => 'u32' );

say addition(1,2);
