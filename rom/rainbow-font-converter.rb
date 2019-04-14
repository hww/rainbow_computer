#!/usr/bin/ruby
# coding: utf-8

file = File.open("rainbow-font.BIN", "rb")
contents = file.read.bytes
puts "RAINBOW COMPUTER"
puts "FONT"
puts "SIZE: #{contents.size}"

for y in 0..15 do
	for l in 0..7 do
		for x in 0..15 do
			addr = (x * 16 + y) * 8 + l
			data = contents[addr]
                        for bit in [128,64,32,16,8,4,2,1] do
                          if data & bit > 0
                            print " "
                          else
                            print "█"
                          end
                        end
			print " "
		end
		print "\n"
	end
        print "\n"
end
