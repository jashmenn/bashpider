usage =<<-eof
Usage: #{$0} infile > output

takes infile of format 

    epoch pages

and converts it into 

    seconds-since-start pages-since-last

eof

unless ARGV.size == 1
  puts usage
  exit
end

infile = ARGV[0]

File.open(infile, "r") do |infile|
  start_time = nil
  last_count = nil
  while (line = infile.gets)
    line = line.strip
    time, count = *(line.split(/ /).collect{|a| a.to_i})
    start_time = time unless start_time
    count_since_last = last_count ? count - last_count : 0
    rel_time = time - start_time
    puts "#{rel_time},#{count_since_last}"
    last_count = count
  end
end
