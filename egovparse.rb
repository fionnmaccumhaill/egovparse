require 'rubygems'
require 'fileutils'
require 'lib/ctdata_create_index.rb'

# Ruby application code.
# This code is not ready to run and is just a placeholder at present.

puts "args:"+ARGV.length.to_s
appName=ARGV[0]
pathName=ARGV[1]
puts "App Name:"+appName.to_s+" path:"+pathName.to_s
puts "last char:"+pathName[-1, 1]

