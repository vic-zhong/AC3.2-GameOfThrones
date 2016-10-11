# AC3.2-GameOfThrones

## Objectives

* To reinforce Table Views by exercising
	* The three key data source delegate methods
	* Storyboard segues
	* Passing data to a view controller in ```prepare(for:)```

## Assignment

Write a table view driven app that lists the Game of Thrones episode titles in a table, and upon row
selection opens a detail view with the same or optionally more data.

### Steps

1. Fork this repo.
2. Go to your own fork. To verify this, check that your github username is in the URL and C4Q's isn't. 
Note Safari doesn't reveal the full URL until you click on it. (For this and other reasons I use Chrome).
3. Clone your own fork of the repo. This is done by clicking the green ```Clone or download``` button,
copying the URL, going to your project directory and typing:
	
	```
	git clone <url_you_just_copied>
	```
4. Work on your project.
5. When done, commit and push to your repo.

### Instructions

After you clone the project and open it you should have a working app with an empty table. 
Complete the following steps:

1. Make a custom class file with these contents:

	```swift
	class GOTEpisode {
	    let name: String
	    let number: Int
	    let airdate: String

	    init(name: String, number: Int, airdate: String) {
	        self.name = name
	        self.number = number
	        self.airdate = airdate
	    }
	    
	    convenience init?(withDict dict: [String:Any]) {
	        if let name = dict["name"] as? String,
	            let number = dict["number"] as? Int,
	            let airdate = dict["airdate"] as? String {
	            self.init(name: name, number: number, airdate: airdate)
	        }
	        else {
	            return nil
	        }
	    }
	}
	```
It will be our model. Each instance of this class holds one episode of the show. Therefore our 
table view controller will load a set of them into an array.

1. Read the data in from the JSON file included in the project. This step is not the focus
of the exercise so just set it up and don't think about it yet.
	
	1. Add this method to the ```GameOfThronesTableViewController``` class:
		```swift
		func loadData() {
	        guard let path = Bundle.main.path(forResource: "got", ofType: "json"),
	            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options:  NSData.ReadingOptions.mappedIfSafe),
	            let dict = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as? NSDictionary else {
	                return
	        }
	        
	        if let episodes = dict?.value(forKeyPath: "_embedded.episodes") as? [[String:Any]] {
	            for epDict in episodes {
	                if let ep = GOTEpisode(withDict: epDict) {
	                    self.episodes.append(ep)
	                }
	            }
	        }
	    }
		```
	1. Add this property to the ```GameOfThronesTableViewController``` class:

		```swift
		var episodes = [GOTEpisode]()
		```

	1. Call the ```loadData``` method you just created in ```viewDidLoad```.

3. Make a custom class file with these contents

	```swift
	class GOTEpisode {
	    let name: String
	    let number: Int
	    let airdate: String

	    init(name: String, number: Int, airdate: String) {
	        self.name = name
	        self.number = number
	        self.airdate = airdate
	    }
	    
	    convenience init?(withDict dict: [String:Any]) {
	        if let name = dict["name"] as? String,
	            let number = dict["number"] as? Int,
	            let airdate = dict["airdate"] as? String {
	            self.init(name: name, number: number, airdate: airdate)
	        }
	        else {
	            return nil
	        }
	    }
	}
	```

2. Complete the implementations of  the **mighty three** Table View Data Source delegate methods 
(these are **still** incomplete):

	```swift
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
	``` 

3. Be sure to make all the connections between the Table View in the storyboard and the code:
	1. The class name in the identity inspector must match your view controller's class.
	1. The reuse identifier in the storyboard and in ```cellForRowAt``` must agree.
	1. The cell type should not be custom.

4. Populate the table with titles and the airdate as the detail title.

5. Create your own detail view controller to open when selected. Be sure to:
	1. Create the segue in the storyboard
	1. Implement ```prepare(for:)``` passing **one** ```GOTEpisode``` object to your detail.
	1. You have flexibility with what you want to display and how you want to display it. If you just 
	want to practice Table Views and segues then you'll be done re-displaying the title in the detail.
	1. Challenge #1. Use autolayout to build a nice detail page.
	1. Challenge #2. Grab more data out of the JSON to build a richer detail page. You'll still be 
	extracting the data on the table view page but you won't be displaying it.