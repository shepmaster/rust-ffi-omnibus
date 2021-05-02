use strict;
use warnings;
use 5.014;
use FFI::Platypus 1.00;

my $ffi = FFI::Platypus->new(
  api  => 1,
  lang => 'Rust',
);
$ffi->mangler(sub { "zip_code_database_$_[0]" });
$ffi->find_lib( lib => 'objects' );
$ffi->load_custom_type('::PtrObject' => 'ZipCodeDatabase' => 'ZipCodeDatabase' );

package ZipCodeDatabase {

  $ffi->attach( new => [] => 'opaque' => sub {
    my($xsub, $class) = @_;
    my $ptr = $xsub->();
    bless { ptr => $ptr }, $class;
  });

  $ffi->attach( populate => ['ZipCodeDatabase']);
  $ffi->attach( population_of => ['ZipCodeDatabase','string'] => 'u32');

  $ffi->attach( free => ['opaque'] => sub {
    my($xsub, $self) = @_;
    if(my $ptr = delete $self->{ptr}) {
      $xsub->($ptr);
    }
  });

}

my $database = ZipCodeDatabase->new;

$database->populate;
my $pop1 = $database->population_of("90210");
my $pop2 = $database->population_of("20500");

say $pop1 - $pop2;
