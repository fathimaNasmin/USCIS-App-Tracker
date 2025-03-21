//
//  NewsXMLDelegate.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 3/13/25.
//

import Foundation

class NewsParser: NSObject, XMLParserDelegate {
	private var newsItems: [News] = []
	private var currentElement = ""
	private var currentTitle = ""
	private var currentLink = ""
	private var currentDescription = ""
	private var currentPubDate = ""
	private var currentSource = ""
	
	init(completionHandler: ( ([News]) -> Void)? = nil) {
		self.completionHandler = completionHandler
	}
	
	var completionHandler: (([News]) -> Void)?
	
	func parseRSSFeed() {
		guard let url = URL(string: "https://www.uscis.gov/news/rss-feed/23269") else { return }
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data, error == nil else {
				print("Error fetching data:", error?.localizedDescription ?? "Unknown error")
				return
			}
			
			let parser = XMLParser(data: data)
			parser.delegate = self
			parser.parse()
		}
		task.resume()
	}
	
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
		
		currentElement = elementName
		
		if currentElement == "item" {
			currentTitle = ""
			currentLink = ""
			currentDescription = ""
			currentPubDate = ""
			currentSource = ""
		}
	}
	
	func parser(_ parser: XMLParser, foundCharacters string: String) {
		switch currentElement {
		case "title":
			currentTitle += string.trimmingCharacters(in: .whitespacesAndNewlines)
		case "link":
			currentLink += string.trimmingCharacters(in: .whitespacesAndNewlines)
		case "description":
			currentDescription += string
		case "pubDate":
			currentPubDate += string.trimmingCharacters(in: .whitespacesAndNewlines)
		case "dc:creator" :
			currentSource += string.trimmingCharacters(in: .whitespacesAndNewlines)
		default:
			break
		}
	}
	
	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName: String?) {
		if elementName == "item" {
			let newsItem = NewsAPIModel(id: UUID(), title: currentTitle, link: currentLink, description: currentDescription, pubDate: currentPubDate, source: currentSource).domainModel
			newsItems.append(newsItem)
		}
	}
	
	func parserDidEndDocument(_ parser: XMLParser) {
		DispatchQueue.main.async {
			self.completionHandler?(self.newsItems)
		}
	}
	
}
