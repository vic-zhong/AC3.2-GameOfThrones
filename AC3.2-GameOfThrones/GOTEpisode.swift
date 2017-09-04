//
//  GOTEpisode.swift
//  AC3.2-GameOfThrones
//
//  Created by Victor Zhong on 10/13/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class GOTEpisode {
	let name: String
	let number: Int
	let airdate: String
	let season: Int
	let summary: String
	let url: String
	let imageMedium: String
	let imageOriginal: String
	
	init(name: String, number: Int, airdate: String, season: Int, summary: String, url: String, imageMedium: String, imageOriginal: String) {
		self.name = name
		self.number = number
		self.airdate = airdate
		self.season = season
		self.summary = summary
		self.url = url
		self.imageMedium = imageMedium
		self.imageOriginal = imageOriginal
	}
	
	convenience init?(withDict dict: [String:Any]) {
		if let name = dict["name"] as? String,
			let number = dict["number"] as? Int,
			let airdate = dict["airdate"] as? String,
			let season = dict["season"] as? Int,
			let summary = dict["summary"] as? String,
			let url = dict["url"] as? String,
			let image = dict["image"] as? [String:Any],
			let imageMedium = image["medium"] as? String,
			let imageOriginal = image["original"] as? String {
			self.init(name: name, number: number, airdate: airdate, season: season, summary: summary, url: url, imageMedium: imageMedium, imageOriginal: imageOriginal)
		}
		else {
			return nil
		}
	}
	
	public func airdateInMMDDYYYY(for date: String) -> String {
		var newDate = String()
		let separatedDate = date.components(separatedBy: "-")
		switch separatedDate[1] {
		case "01": newDate += "January"
		case "02": newDate += "February"
		case "03": newDate += "March"
		case "04": newDate += "April"
		case "05": newDate += "May"
		case "06": newDate += "June"
		case "07": newDate += "July"
		case "08": newDate += "August"
		case "09": newDate += "September"
		case "10": newDate += "October"
		case "11": newDate += "November"
		case "12": newDate += "December"
		default:
			return date
		}
		newDate += " \(separatedDate[2]), \(separatedDate[0])"
		return newDate
	}
}
