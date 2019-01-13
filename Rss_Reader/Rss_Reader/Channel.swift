//
//  Channel.swift
//  Rss_Reader
//
//  Created by Pascal Fritz on 12.01.19.
//

import Cocoa

class Channel: NSObject {

    // Mark: Properties
    var title: String
    var link: URL
    var channelDescription: String
    var language: String
    
    
    init(title: String, link: String, channelDescription: String, language: String) {
        self.title = title
        self.link = URL(string: link)!
        self.channelDescription = channelDescription
        self.language = language
    }
    // TODO: getter einsetzen
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
}
