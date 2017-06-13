
for year in 1985 1990 1995 2000 2005; do
  echo 'compute' ${year}
  ruby ./src/d_profile.rb < ./work/${year}.txt > ./result/${year}.result &
done;
wait
