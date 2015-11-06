require 'rubygems'
require 'fileutils'

# puts "starting" 

require './lib/CTDataIndexModule'
require './lib/CTDataRetrieveModule'

JSON_FILE_CONST = "dataidx.json"
JSON_DIR_CONST = "datafiles/"

def createIndex(aIndexFile)
    tm = Object.new
    tm.extend(CTDataIndexModule)
    tm.echo("creating index")
    tm.createIdx(aIndexFile)
end

def showStats(aIndexFile)
    tm = Object.new
    tm.extend(CTDataIndexModule)
    tm.echo("creating index")
    tm.showIndexStats(aIndexFile)
end

def retrieveAllDatasets()
    tm = Object.new
    tm.extend(CTDataRetrieveModule)
    tm.retrieve(JSON_DIR_CONST+JSON_FILE_CONST, JSON_DIR_CONST)
end

def retrieveDataset(aDatasetIndex)
    tm = Object.new
    tm.extend(CTDataRetrieveModule)
    tm.retrieveDataset(aDatasetIndex, JSON_DIR_CONST)
end

def cleanup(aDataDirectory)
    Dir.foreach(aDataDirectory) do |item|
        next if item == '.' or item == '..'
  # do work on real items
        fsize = File.stat(aDataDirectory+item).size
        if fsize == 0
         #   puts item + " " + fsize.to_s
            ds = item.split(".").first
            retrieveDataset(ds)
        end
    end
end

# Ruby application code.
# This code is not ready to run and is just a placeholder at present.

if ARGV.empty?
    # fix the usage display
    puts "Usage is: ruby egovparse.rb [index] indexfile"
    puts "          ruby egovparse.rb [stats] indexfile"
    puts "          ruby egovparse.rb [retrieve] dataindex "
    puts "          ruby egovparse.rb [retrieve] "
    puts "          ruby egovparse.rb [cleanup] "
    exit 1
end

# puts "args:"+ARGV.length.to_s
aCommand=ARGV.shift
# puts "command:"+aCommand
# pathName=ARGV[1]
# puts "App Name:"+appName.to_s+" path:"+pathName.to_s
# puts "last char:"+pathName[-1, 1]

if aCommand == "index"
    indexFile = ARGV.shift || JSON_DIR_CONST+JSON_FILE_CONST
  #  puts "index file:"+indexFile
    createIndex(indexFile)
end

if aCommand == "stats"
    indexFile = ARGV.shift || JSON_DIR_CONST+JSON_FILE_CONST
  #  puts "index file:"+indexFile
    showStats(indexFile)
end

if aCommand == "retrieve"
    if ARGV.length == 0
        retrieveAllDatasets()
    else
        retrieveDataset(ARGV[0])
    end
    # retrieveData()
end

if aCommand == "cleanup"
    cleanup(JSON_DIR_CONST)
end