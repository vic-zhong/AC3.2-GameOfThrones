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
		loadData()
		navigationController?.navigationBar.backgroundColor = .gray
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
		cell.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Season \(section + 1)"
	}
	
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
