//
//  Item.swift
//  Rss_Reader
//
//  Created by Pascal Fritz on 12.01.19.
//

import Foundation
//item stores the informations for one item in an Channel
class Item: NSObject{
    
    //MARK: Properties
    var title: String
    var itemDescription: String
    var link: URL
    var pubDate: NSDate
    var category: String
    var author: String
    
    //MARK: Initialization
    init(title: String, link: String, itemDescription: String, pubDate: String?, category: String?, author: String?){
        self.title = title
        self.link = URL(string: link)!
        self.itemDescription = itemDescription
        
        let dateString = pubDate
        let dateFormatter = DateFormatter()
        // date format needs to match input string format
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        self.pubDate = dateFormatter.date(from: dateString ?? "29-05-2036")! as NSDate
        self.category = category ?? ""
        self.author = author ?? ""
    }
    
    func getTitle() -> String{
        return title
    }
    func getDescription() -> String{
        return itemDescription
    }
    func getLink() -> URL {
        return link
    }
    func getPubDate() -> NSDate {
        return pubDate
    }
    func getCategory() -> String {
        return category
    }
    func getAuthor() -> String {
        return author
    }
    
    
}
