#!/usr/bin/ruby

=begin Sample places.txt

icc=ICC
alex=Alexandra House
ge=Great Eagle Center

25/4,ge
28/4,ge
4/5,icc
9/5,ge
11/5,Hong Luen Road
13/5,City Point
18/5,alex
19/5,ge,taxi

=end

infile = File.open("places.txt", "r")
outfile = File.open("okplaces.csv", "w")

mapping = []

infile.each do |line|
    line.chomp!
    break if line.length == 0
    assgin = line.split('=')
    if assgin.length != 2 then
        abort("wrong assignment format: #{line}")
    end
    mapping << assgin
end

tours = infile.read
mapping.each do |old, new|
    tours.gsub!(old, new)
end

tours.split("\n").each do |tour|
    tour.chomp!
    nfield = tour.split(',').length
    if not (2..3).member? nfield then
        abort("wrong number of fields: #{nfield} #{tour}")
    end
    tour << ",bus" if nfield == 2
    outfile.puts tour    
end
