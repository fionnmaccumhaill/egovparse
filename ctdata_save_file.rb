require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'json/add/core'

# Read the referenced file from the CT Open Data website and
#    save to the local directory
def getFile(aFileIdx)
    open(aFileIdx+'.json', 'wb') do |file|
        file << open('https://data.ct.gov/resource/'+aFileIdx+'.json').read
    end
    return ''
end

# Load the index file into a json object
def loadFileIdx(aFileName)
    jf = ''
    File.open( aFileName, "r" ) do |f|
        jf = JSON.load( f )
    end
    return jf
end

JSON_FILE_CONST = "dataidx.json" 
jfIdx = ARGV[0].to_i     # the first arg is index of the json array
                         #    created with ctdata_create_index

jsonIdx = loadFileIdx(JSON_FILE_CONST)

getFile(jsonIdx[jfIdx]["dataId"])