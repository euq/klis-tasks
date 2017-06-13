#! /Users/hiramatsumakoto/.rbenv/shims/ruby
require 'natto'
require 'optparse'

params = ARGV.getopts("y:")
query_year = params['y'] || '2000'

while line = gets
  nm = Natto::MeCab.new('-Owakati')
  # url, title, author, belong, year, type = line.chomp.split(/\t/)
  _, title, _, _, year, _ = line.chomp.split(/\t/)
  year = year.gsub(/.*\|\|/, '')

  next if year != query_year
  # _, title, *_ = line.chomp.split(/\t/)
  nm.parse(title).split().each do |morph|
    puts morph
  end
end

