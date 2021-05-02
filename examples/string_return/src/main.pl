use strict;
use warnings;
use 5.010;
use FFI::Platypus 1.00;

my $ffi = FFI::Platypus->new(
  api  => 1,
  lang => 'Rust',
);
$ffi->find_lib( lib => 'string_return' );

$ffi->attach_cast( opaque_to_string => 'opaque' => 'string');
$ffi->attach( theme_song_free => ['opaque'] );
$ffi->attach( theme_song_generate => ['u8'] => 'opaque' => sub {
  my($xsub, $length) = @_;
  my $ptr = $xsub->($length);
  my $str = opaque_to_string($ptr);
  utf8::decode($str);
  theme_song_free($ptr);
  return $str;
});

say theme_song_generate(5);
