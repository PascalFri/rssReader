//
//  Channel.swift
//  Rss_Reader
//
//  Created by Pascal Fritz on 12.01.19.
//

import Cocoa
import os.log

// the channel stores the informations from one Rss-Feed
class Channel: NSObject {
    
    // MARK: Properties
    var title: String
    var link: URL
    var channelDescription: String
    var language: String
    var items: [Item]
    
    // MARK: Types
    
    init(title: String, link: URL, channelDescription: String, language: String, items: [Item]) {
        self.title = title
        self.link = link
        self.channelDescription = channelDescription
        self.language = language
        self.items = items
    }
    
    func getTitle() -> String{
        return title
    }
    func getLink() -> URL{
        return link
    }
    func getDescription() -> String{
        return channelDescription
    }
    
    func getLanguage() -> String {
        return language
    }
    
    func getItems() -> [Item] {
        return items
    }
}
