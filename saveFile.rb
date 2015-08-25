require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'json/add/core'

def getFile(aFileIdx)
    puts aFileIdx
    # https://data.ct.gov/resource/dataId.json
    open(aFileIdx+'.json', 'wb') do |file|
        file << open('https://data.ct.gov/resource/'+aFileIdx+'.json').read
    end
    return ''
end

def loadFileIdx(aFileName)
    jf = ''
    File.open( aFileName, "r" ) do |f|
        jf = JSON.load( f )
    end
#    puts jf
    return jf
end

JSON_FILE_CONST = "dataidx.json" 
jfIdx = ARGV[0].to_i

jsonIdx = loadFileIdx(JSON_FILE_CONST)
puts 'after loadFileIdx'
# puts("length:"+jsonIdxArray.length.to_S)
puts jsonIdx.length
puts jsonIdx[jfIdx]["url"]+" : "+jsonIdx[jfIdx]["dataId"]
getFile(jsonIdx[jfIdx]["dataId"])