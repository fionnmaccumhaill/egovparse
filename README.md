The State of Connecticut provides open datasets at:

https://data.ct.gov/browse

The datasets contain everything from a list of apple growers in CT to a list
of Department of Revenue Services tax credits claimed. There are csv files,
maps, charts and calendars. 

You can use the CT Open Data website to search for the data you want. However,
I could not find a file with an index to all the available datasets which would be handy to programmatically search or pull the datasets. I decided a JSON file with a list of all datasets would be useful so I wrote a small Ruby script to screen scrape the CT Open Data website and pull the information on the 500+ datasets that are currently available. This repository:

https://github.com/fionnmaccumhaill/egovparse

contains the Ruby script and the JSON file with the information about the 
datasets. Each row in the JSON file contains the information about one dataset.
The format of each row is:

"dataId":   dataId   - the dataId for the access to the file

"url":      url      - the link to the page on the CT Open Data website for this dataset

"dataDesc": dataDesc  - a description of the dataset. This is a string which can
                        be very long.
                     
Here is an example row from the file:

{
  "dataId": "ub7n-cmry",
  "url": "https://data.ct.gov/Environment-and-Natural-Resources/apples/ub7n-cmry",
  "dataDesc": "List of Apple growers in Connecticut"
}
                     
To access the dataset use the following url:

https://data.ct.gov/resource/dataId.json

Where dataId is the dataId from the JSON file. You can also substitute .csv for .json in the url.

The non-text datasets, such as maps, are more problematic. Some of the map datasets will give you a JSON file with coordinates. Most seem to give you nothing. 

The Ruby script that controls the creation of the index and pulling the datasets from the data.ct.gov is in the egovparse.rb script.

The Ruby code that does the index creation and pulling the data is in the lib directory of the repository.

The script will create a file called dataidx.json and will put it in the datafiles directory. I will upload the index periodically in case you do not wish to create it yourself. The script to create the index runs for several minutes on my MacBook Pro so be patient. 

The egovparse.rb script also allows you to pull all or any of the datasets. Check the code for the format. If you decide to pull all of the datasets yourself be aware that, at present time, there are 500+ datasets and they take up ~300MB. 