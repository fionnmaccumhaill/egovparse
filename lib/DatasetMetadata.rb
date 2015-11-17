require 'rubygems'
require 'json'
require 'json/add/core'

class DatasetMetadata
    
    attr_writer :createDate
    attr_writer :retrieveDate
    attr_writer :dataID
    
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
        @dataAttributes.push(aAttribute)
    end
    
    def initialize()
        @dataAttributes = Array.new
    end
    
    def to_json
        {'dataID' => dataID,
            'created' => @createDate,
            'retrieved' => retrieveDate,
            'attributes' => dataAttributes}.to_json
    end
    
    instance = DatasetMetadata.new
    instance.addAttribute("town")
    instance.addAttribute("city")
    instance.addAttribute("school")
    instance.createDate = '2015-01-09'
    instance.retrieveDate = '2015-11-02'
    instance.dataID = 'ID1-012345'
    puts instance.dataAttributes[0]
    puts instance.to_json()
end