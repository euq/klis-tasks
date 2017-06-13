
for year in 1985 1990 1995 2000 2005; do
  echo 'parse' ${year}
  ruby ./src/parse.rb -y ${year} < ./data/dataset_201701_h_soshin.tsv > ./work/${year}.txt &
done;
wait
