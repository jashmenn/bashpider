#!/usr/bin/env ruby
# pick random lines from a file without loading the whole thing into memory. 
# based on: http://www.regexprn.com/2008/11/read-random-line-in-large-file-in.html
require 'pp'
 
unless ARGV.size >= 2
  puts "usage: $0 file count"
  exit 1
end
 
filename,count = ARGV[0],ARGV[1].to_i
f = open(filename, "r")
file_size = File.stat(filename).size
1.upto(count) do
  amount = (f.tell + rand(file_size - 1)) % file_size
  f.seek(amount)
  f.readline
  line = f.readline
  print line[0..-1]
end
