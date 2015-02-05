package CJE::Retrieval;
my %weight;

sub search{
  $class = shift;
  @stemmed = @_;
  foreach (@stemmed){
    @query = split(' ', $_);
    open(FILE, "index.txt");
    while(<FILE>){
      if($_ =~ $query[1]){
        @item = split(" ", $_);
        $weight{$item[0]} += $item[4];
      }
    }
  }
  close(FILE);
  my $hit = keys %weight;
  print "hit: $hit\n";
  foreach $doc_id(sort { $weight{$b} <=> $weight{$a} } keys %weight){
    print "$doc_id : $weight{$doc_id}\n";
  }
}
1;
