package CJE::Extract;
my @words;
my $flag;

sub extract{
  my $class = shift;
  my $doc = shift;
  open(FILE, $doc) || die;;
  while(<FILE>){
    if ($_ =~ /<NUM>(.*)<\/NUM>/){
      $lavel = $1;
    }
    if ($_ =~ /<TEXT>/){
      $flag = 1;
      next;
    }
    if ($_ =~ /<\/TEXT>/){
      $flag = 0;
      next;
    }
    if ($flag == 1){
      my %words = split(" ", $_);
      foreach(%words){
        if (!($_ eq "")){
          $_ =~ tr/A-Z/a-z/;
          $_ =~ s/(\.|\,)$//;
          push(@words, "$lavel $_\n");
        }
      }
    }
  }
  close(FILE);
  return @words;
}
1;
