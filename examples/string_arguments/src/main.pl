use strict;
use warnings;
use 5.010;
use FFI::Platypus 1.00;

my $ffi = FFI::Platypus->new(
  api  => 1,
  lang => 'Rust',
);
$ffi->find_lib( lib => 'string_arguments' );
$ffi->attach( how_many_characters => [ 'string' ] => 'u32' );

say how_many_characters("göes to élevên");
