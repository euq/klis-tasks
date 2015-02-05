package CJE::Idf;
my %df;

sub calc{
  my $class = shift;
  my %tf = @_;
  foreach my $key(keys(%tf)){
    @item = split(" ", $key);
    chomp($item[0]);
    chomp($item[1]);
    $doc_num{$item[0]}++;
    $df{$item[1]}++ if(!($item[1] eq ""));
  }
  open(OUT, ">", "index.txt") || die;
  foreach my $key(sort keys(%tf)){
    my @elem = split(" ", $key);
    my $N = keys %doc_num;
    my $dft= $df{$elem[1]};
    $dft= log($N / $dft) + 1;
    $idf = $tf{$key} * $dft;
    print OUT "$key $tf{$key} $dft $idf\n";
  }
  close(OUT);
}
1;
