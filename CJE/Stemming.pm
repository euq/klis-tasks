package CJE::Stemming;
my @stemmed;

sub stemming{
  my $class = shift;
  my @stopped = @_;
  foreach(@stopped){
    if($_ =~ /ies$/){
      $_ =~ s/ies$/y/;
      push(@stemmed, $_);
      next;
    }
    if($_ =~ /es$/){
      $_ =~ s/es$//;
      push(@stemmed, $_);
      next;
    }
    if($_ =~ /s$/){
      $_ =~ s/s$//;
      push(@stemmed, $_);
      next;
    }
    if($_ =~ /ed$/){
      $_ =~ s/ed$//;
      push(@stemmed, $_);
      next;
    }
    if($_ =~ /ing$/){
      $_ =~ s/ing$//;
      push(@stemmed, $_);
      next;
    }
    push(@stemmed, $_);
  }
  return @stemmed;
}
1;
