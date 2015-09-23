require 'rubygems'
require 'fileutils'

puts "starting" 

require './lib/CTDataIndexModule'
require './lib/CTDataRetrieveModule'

JSON_FILE_CONST = "dataidx.json"
JSON_DIR_CONST = "datafiles/"

def createIndex()
    tm = Object.new
    tm.extend(CTDataIndexModule)
    tm.echo("creating index")
    tm.createIdx()
end

def retrieveData()
    tm = Object.new
    tm.extend(CTDataRetrieveModule)
    tm.echo("retriveing data")
    tm.echo("something something something else")
    tm.retrieve(JSON_DIR_CONST+JSON_FILE_CONST, JSON_DIR_CONST)
end

# Ruby application code.
# This code is not ready to run and is just a placeholder at present.

puts "args:"+ARGV.length.to_s
appName=ARGV[0]
pathName=ARGV[1]
puts "App Name:"+appName.to_s+" path:"+pathName.to_s
puts "last char:"+pathName[-1, 1]

if ARGV[0] == "index"
    createIndex()
end

if ARGV[0] == "retrieve"
    retrieveData()
end

puts "done"