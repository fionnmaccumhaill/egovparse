require 'rubygems'
require 'json'
require 'json/add/core'

class DatasetMetadata
    def createDate
        @createDate
    end
    
    def retrieveDate
        @retrieveDate
    end
    
    def dataID
        @dataID
    end
    
    def dataAttributes
        @dataAttributes
    end
    
    def addAttribute(aAttribute)
    end
    
end