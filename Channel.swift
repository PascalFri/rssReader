//
//  Channel.swift
//  Rss_Reader
//
//  Created by Pascal Fritz on 12.01.19.
//

import Cocoa
import os.log

//the channel stores the informations from one Rss-Feed
class Channel: NSObject, NSCoding {
    
    

    // MARK: Properties
    var title: String
    var link: URL
    var channelDescription: String
    var language: String
    var items: [Item]
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("channel")
    
    // MARK: Types
    struct PropertyKey {
        static let title = "title"
        static let link = "link"
        static let channelDescription = "channelDescription"
        static let language = "language"
        static let items = "items"
    }
    
    init(title: String, link: URL, channelDescription: String, language: String, items: [Item]) {
        self.title = title
        self.link = link
        self.channelDescription = channelDescription
        self.language = language
        self.items = items
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
    
    func getItems() -> [Item] {
        return items
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(link, forKey: PropertyKey.link)
        aCoder.encode(channelDescription, forKey: PropertyKey.channelDescription)
        aCoder.encode(language, forKey: PropertyKey.language)
        aCoder.encode(items, forKey: PropertyKey.items)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String
            else {
                os_log("Unable to decode the title for an channel object.", log: OSLog.default, type: .debug)
                return nil
        }
        let link = aDecoder.decodeObject(forKey: PropertyKey.link) as? URL
        let channelDescription = aDecoder.decodeObject(forKey: PropertyKey.channelDescription)
        let language = aDecoder.decodeObject(forKey: PropertyKey.language)
        let items = aDecoder.decodeObject(forKey: PropertyKey.items) as? [Item]
        
        // Must call desigated initilizers
        self.init(title: title, link: link!, channelDescription: channelDescription as! String, language: language as! String, items: items!)
    }
}
