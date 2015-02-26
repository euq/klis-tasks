use lib 'path/to/cje3/script/3';
use CJE::Extract;
use CJE::Stopword;
use CJE::Stemming;
use CJE::Tf;
use CJE::Idf;
use CJE::Retrieval;

sub indexing{
  my @stemmed = @_;
  my %tf = CJE::Tf->calc(@stemmed);
  my %idf = CJE::Idf->calc(%tf);
  return 0;
}

sub searching{
  my @stemmed = @_;
  my @retrieval = CJE::Retrieval->search(@stemmed);
  return 0;
}

my $file = $ARGV[0];
my @words = CJE::Extract->extract($file);
my @stopped = CJE::Stopword->remove_stops(@words);
my @stemmed = CJE::Stemming->stemming(@stopped);

if ($file eq 'documents.txt'){
  print "------------------------------------------------------------------------------------------------------------------------\n";
  print "| 引数に$fileが指定されました。\n|・extract\n|・stopword\n|・stemming\n|・tf\n|・idf\n|を実行し、index.txtを作成します。\n";
  print "| カレントディレクトリにindex.txtが作成されます。                                                                       \n";
  print "------------------------------------------------------------------------------------------------------------------------\n";
  indexing(@stemmed);
}elsif($file eq 'query.txt'){
  print "----------------------------------------------------------------------------------------------------------------------\n";
  print "| 引数に$fileが選択されました。\n|・extract\n|・stopword\n|・stemming\n|・retrieve\n|を実行し、検索結果を表示します。 \n";
  print "----------------------------------------------------------------------------------------------------------------------\n";
  searching(@stemmed);
}else{
  print "-------------------------------------------------------------------------------------------------------------\n";
  print "|コマンドライン引数を指定してください。\n|実行例:\n|・perl main.pl documents.txt\n|・perl main.pl query.txt  \n";
  print "-------------------------------------------------------------------------------------------------------------\n";
}
