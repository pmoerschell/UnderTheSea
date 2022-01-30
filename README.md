# UnderTheSea
App On Board Under the Sea Coding Challenge

C++, Qt, & QML application 

Under the sea
The task is to create a Qt/QML application that displays data from the remote server in grid form. Below you can see a possible look of the target application:



It's needed to download JSON with a hierarchical data structure containing folders and objects. Folders can also contain subfolders.
Each object has 3 mandatory fields: name, icon, and url. Name and icon are used in UI, url should be loaded in browser when user clicks on an item.
Each folder contains 3 mandatory fields: name, icon, and children, which is a list of objects and folders.
	It should be possible to enter folders and see their contents, also it should be possible to go one level up (button "Up" on demo screenshot).
	Use Qt/C++ for network and data models, and QML for UI presentation.

URL to fetch data from:
https://s3.amazonaws.com/com.buildbox.dev.interview/UnderTheSea/data.json
