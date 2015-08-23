The State of Connecticut provides open datasets at:

https://data.ct.gov/browse

The datasets contain everything from a list of apple growers in CT to a list
of Department of Revenue Services tax credits claimed. There are csv files,
maps, charts and calendars. 

You can use the CT Open Data website to search for the data you want. However,
I could not find a file with an index to all the available datasets which would
be handy to programmatically pull the datasets. I decided a JSON file with a
list of all datasets would be useful so I wrote a small Ruby script to screen
scrape the CT Open Data website and pull the information on the 600+ datasets
that are currently available. This repository:

https://github.com/fionnmaccumhaill/egovparse

contains the Ruby script and the JSON file with the information about the 
datasets. Each row in the JSON file contains the information about one dataset.
The format of each row is:

"dataId":   dataId   #the dataId for the access to the file
"url":      url      #the link to the page on the CT Open Data website for this dataset
"dataDesc": dataDesc #a description of the dataset. This is a string which can
                     #be very long.
                     
Here is an example row from the file:

{
  "dataId": "ub7n-cmry",
  "url": "https://data.ct.gov/Environment-and-Natural-Resources/apples/ub7n-cmry",
  "dataDesc": "List of Apple growers in Connecticut"
}
                     
To access the dataset use the following url:

https://data.ct.gov/resource/dataId.json
Where dataId is the dataId from the JSON file. You can also substitute
   .csv for .json in the url.
   I have not worked out the details of pulling non-text datasets from the site
   but I will update the README when I have done so.

The getHtml.rb Ruby script will create a file called dataidx.json which will be
updated periodically by me. If you wish to create your own file run the Ruby
script. You are going to need the nokogiri and JSON gems installed before you
run the script.Be aware this is one of the first Ruby scripts I have ever written
so there might be bugs and other bad programming techniques scattered throughout
the code. At present there are no useful comments in the code and the variable
names need to be improved. 