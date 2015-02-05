package CJE::Stopword;
my @stopped;

sub remove_stops{
  my $class = shift;
  my @words = @_;
  foreach(@words){
    my @line = split(" ", $_);
    if(include(@stops, $line[1]) == 0){
      push(@stopped, $_);
    }
  }
  return @stopped;
}

sub include{
  my $word = shift;
  my @stops = qw(a the and in of is am for to on by as );
  foreach (@stops){
    return 1 if $_ eq $word;
  }
  return 0;
}
1;
