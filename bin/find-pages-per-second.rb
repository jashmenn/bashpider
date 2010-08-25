usage =<<-eof
Usage: #{$0} infile

takes infile of format 

    rel_time,count_since_last

And gives you the mean number of pages per second.

We were using R to get some basic statistics, but at our watch started to take
more than one second so we were dropping entries.

eof

unless ARGV.size == 1
  puts usage
  exit
end

infile = ARGV[0]

File.open(infile, "r") do |infile|
  sum = 0
  last_time = nil
  while (line = infile.gets)
    line = line.strip
    time, count = *(line.split(/,/).collect{|a| a.to_i})
    last_time = time
    sum = sum + count 
  end
  puts "Mean pages per second: #{sum/last_time}"
end
