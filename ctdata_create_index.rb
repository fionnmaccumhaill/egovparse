require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'json/add/core'

def getPage(aPageNumber)
    return Nokogiri::HTML(open("https://data.ct.gov/browse?page="+aPageNumber))  
end

def getUrl(aStructure)
    return aStructure.css("a").select{|link| link['itemprop'] == "url"}
end

def getItemScope(aPage)
    return aPage.css("tr").select{|link| link['itemscope'] == "itemscope"}
end

def getNameDesc(aPage)
    return aPage.css("td").select{|link| link['class'] == "nameDesc"}
end

def getDataDesc(aNameDesc)
    return aNameDesc.css("div").select{|link| link['class'] == "description"}
end

def writeJSON(aFileName, aString, aFileAttrib)
    File.open(aFileName, aFileAttrib) {|f| f.write(aString) }
end

DatasetStruct = Struct.new(:dataId, :url, :dataDesc) do
    def to_str
        puts dataId+url
    end
    def to_map
        map = Hash.new
        self.members.each { |m| map[m] = self[m] }
        map
    end
    def to_json(*a)
        to_map.to_json(*a)
    end
end

JSON_FILE_CONST = "dataidx.json" 
pageNumber = 1
iBreak = 9
dataSets = Array.new

while iBreak > 0
    xBreak = 5
    page = getPage(pageNumber.to_s)
    dataRows = getItemScope(page)
    if dataRows.length == 0
        iBreak = 0
    end
    pageNumber += 1
    dataRows.each do |row|
        # puts row.text
        sHref = ''
        sDesc = ''
        sDataId = row['data-viewid']
        names = getNameDesc(row)
        names.each do |dlink|
            data_links = getUrl(dlink)
            data_links.each do |link1|
                sHref = link1['href']
            end
            descriptions = getDataDesc(dlink)
            descriptions.each do |desc| 
                sDesc = desc.text
            end
        end
        dataSets.push(DatasetStruct.new(sDataId, sHref, sDesc))
    end

end
arraySep = ", "+"\n"
aCnt = 0
writeJSON(JSON_FILE_CONST, "["+ "\n", 'w')
dataSets.each do |aRow|
    aCnt += 1
    if dataSets.length <= aCnt 
        arraySep = " "+"\n" 
    end
    writeJSON(JSON_FILE_CONST, JSON.pretty_generate(aRow)+arraySep, 'a')
end
writeJSON(JSON_FILE_CONST, "]", 'a')