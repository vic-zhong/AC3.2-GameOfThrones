//
//  GameOfThronesTableViewController.swift
//  AC3.2-GameOfThrones
//
//  Created by Jason Gresh on 10/11/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class GameOfThronesTableViewController: UITableViewController {
	
	var episodes = [GOTEpisode]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem()
		
		loadData()
		navigationController?.navigationBar.backgroundColor = .gray
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Load data source
	
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
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		let sectionCount = episodes[episodes.endIndex-1].season
		return sectionCount
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		let season = episodes.filter { (episode) -> Bool in
			(episode.season - 1) == section
		}
		
		return season.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "gotVID", for: indexPath) as! GOTEpisodeTableViewCell
		
		let section = episodes.filter { (episode) -> Bool in
			return (episode.season - 1 ) == indexPath.section
		}
		
		let epInfo = section[indexPath.row]
		cell.titleLabel.text = epInfo.name
		cell.detailLabel.text = "Aired on \(epInfo.airdateInMMDDYYYY(for: epInfo.airdate))"
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Season \(section + 1)"
	}
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/
	
	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
	if editingStyle == .delete {
	// Delete the row from the data source
	tableView.deleteRows(at: [indexPath], with: .fade)
	} else if editingStyle == .insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/
	
	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	
	}
	*/
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/
	
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destinationViewController.
		if let tappedEpisodeCell: GOTEpisodeTableViewCell = sender as? GOTEpisodeTableViewCell {
			if segue.identifier == "detailSegue" {
				let detailViewController: DetailViewController = segue.destination as! DetailViewController
				let cellIndexPath: IndexPath = self.tableView.indexPath(for: tappedEpisodeCell)!
				let episode: GOTEpisode = episodes.filter { (episode) -> Bool in
					return (episode.season - 1 ) == cellIndexPath.section }[cellIndexPath.row]
				// Pass the selected object to the new view controller.
				detailViewController.selectedEpisode = episode
				// The below affects the title of the back button in the next view controller
				let backItem = UIBarButtonItem()
				backItem.title = "Episodes"
				navigationItem.backBarButtonItem = backItem
			}
		}
	}
}
