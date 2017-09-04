//
//  DetailViewController.swift
//  AC3.2-GameOfThrones
//
//  Created by Victor Zhong on 10/14/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
	
	internal var selectedEpisode: GOTEpisode!
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var infoLabel: UILabel!
	@IBOutlet weak var summaryLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadData(for: selectedEpisode)
		// Do any additional setup after loading the view.
	}
	
	func loadData(for episode: GOTEpisode) {
		
        /*
        Kingfisher'ed!
        var image: UIImage?
		var data: Data?
		
		//1. Create a url from the string of the url
		let url = URL(string: episode.imageOriginal)
		
		//2. Create a data object out of the url
		if let unwrappedURL = url {
			data = try? Data(contentsOf: unwrappedURL)
		}
		
		//3. Create an image out of the data object created
		if let realData = data {
			image = UIImage(data: realData)
		}
		
		self.imageView.image = image
        */
        
        let url = URL(string: episode.imageOriginal)
        imageView.kf.setImage(with: url)
		
        self.titleLabel.text = episode.name
		self.infoLabel.text = "Season \(episode.season), Episode \(episode.number)\nAired on \(episode.airdateInMMDDYYYY(for: episode.airdate))"
		
		let newSum = episode.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
		
		self.summaryLabel.text = newSum
	}
}
