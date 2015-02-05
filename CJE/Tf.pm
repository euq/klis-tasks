package CJE::Tf;
my %tf;

sub calc{
  my $class = shift;
  my @stemmed = @_;
  foreach(@stemmed){
    chomp($_);
    $tf{$_}++;
  }
  return %tf;
}
1;
