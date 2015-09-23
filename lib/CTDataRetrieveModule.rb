require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'json/add/core'

module CTDataRetrieveModule
    def echo (aString)
        puts "retrieve module:"+aString
    end
    
    # Read the referenced file from the CT Open Data website and
    #    save to the local directory
    def getFile(aFileIdx, aDirectory)
        puts "file index:"+aFileIdx
        begin
            open(aDirectory+aFileIdx+'.json', 'wb') do |file|
            file << open('https://data.ct.gov/resource/'+aFileIdx+'.json').read
            end
        rescue
            puts "error reading index:"+aFileIdx
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
    
    def retrieve(aIndexFile, aOutputDirectory)
        puts("JSON file:"+aIndexFile)
        puts("Data Dir:"+aOutputDirectory)
      #  jfIdx = ARGV[0].to_i   # the first arg is index of the json array
                               # created with ctdata_create_index

        # jfIdx = 12
        jsonIdx = loadFileIdx(aIndexFile)
        puts "length of index:"+jsonIdx.length.to_s
        for jfIdx in 401..jsonIdx.length
            getFile(jsonIdx[jfIdx]["dataId"], aOutputDirectory)
        end
    end

end
 