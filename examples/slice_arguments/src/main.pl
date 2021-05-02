use strict;
use warnings;
use 5.010;
use FFI::Platypus 1.00;

my $ffi = FFI::Platypus->new(
  api  => 1,
  lang => 'Rust',
);
$ffi->find_lib( lib => 'slice_arguments' );
$ffi->attach( sum_of_even => [ 'u32[]', 'isize' ] => 'u32' => sub {
  my($xsub, $n) = @_;
  my $len = @$n;
  return $xsub->($n, $len);
});

say sum_of_even([1,2,3,4,5,6]);
