use strict;
use warnings;
use 5.014;
use FFI::Platypus 1.00;

my $ffi = FFI::Platypus->new(
  api  => 1,
  lang => 'Rust',
);
$ffi->find_lib( lib => 'tuples' );

package Tuple {
  use FFI::Platypus::Record;

  use overload
    '""' => sub { shift->to_string },
    bool => sub { 1 }, fallback => 1;

  record_layout_1(
    $ffi,
    u32 => 'x',
    u32 => 'y',
  );

  sub to_string {
    my($self) = @_;
    sprintf "(%d,%d)", $self->x, $self->y;
  }
}

$ffi->attach( flip_things_around => ['record(Tuple)'] => 'record(Tuple)' );

my $tup = Tuple->new( x => 10, y => 20 );

say flip_things_around($tup);
