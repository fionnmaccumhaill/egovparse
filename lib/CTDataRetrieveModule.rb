require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'json/add/core'

module CTDataRetrieveModule
    # Method: echo 
    # A testing method to allow you to make sure you have
    # set up the invoking code correctly without doing any
    # actual work.
    def echo (aString)
        puts "retrieve module:"+aString
    end
    
    # Method: getFile
    # Parameters:
    # aFileIdx - 
    # aDirectory - 
    # Read the referenced file from the CT Open Data website and
    #    save to a local directory
    def getFile(aFileIdx, aDirectory)
        dsURL='https://data.ct.gov/resource/'+aFileIdx+'.json'
        altDSURL='https://data.ct.gov/api/views/'+aFileIdx
       # puts dsURL
        retryCnt = 0
        currentURL = dsURL
        begin
            open(aDirectory+aFileIdx+'.json', 'wb') do |file|
                file << open(currentURL).read
            end
        rescue
  #          puts "error reading index:"+aFileIdx
            if retryCnt < 1
   #             puts "retry"
                currentURL = altDSURL
                retryCnt += 1
                retry
            end
        end
        return 0
    end

    # Load the index file into a json object
    def loadFileIdx(aFileName)
        jf = ''
        File.open( aFileName, "r" ) do |f|
            jf = JSON.load( f )
        end
        return jf
    end
    
    # Method: retrieve
    # Parameters:
    # aIndexFile -
    # aOutputDirectory -
    # Retrieve all the files in the 
    def retrieve(aIndexFile, aOutputDirectory)
        jsonIdx = loadFileIdx(aIndexFile)
#       puts "length of index:"+jsonIdx.length.to_s
        for jfIdx in 0..jsonIdx.length
            getFile(jsonIdx[jfIdx]["dataId"], aOutputDirectory)
        end
    end
    
    # Method: retrieveDataset
    # Parameters: 
    # aIndex - the index to retrieve from the CT Data website
    # aOutputDirectory - the location where the output file will be written
    # Retrieve a single file from the CT Open Data website
    
    def retrieveDataset(aDSidx, aOutputDirectory)
        getFile(aDSidx, aOutputDirectory)
    end

end
 