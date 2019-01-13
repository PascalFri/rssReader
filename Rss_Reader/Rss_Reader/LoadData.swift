//
//  LoadData.swift
//  Rss_Reader
//
//  Created by Pascal Fritz on 08.01.19.
//

import Cocoa

class LoadData: NSObject {

    func getRssData(url: URL){
        // Set up the URL request
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on a Rss-Feed")
                print(error!)
                return
            }
            // make sure we got data
            guard data != nil else {
                print("Error: did not receive data")
                return
            }
            
            
            var rssData = String(data: data!, encoding: .utf8)!
            self.xmlPrasing(rssData: rssData)
        }
        task.resume()
    }
    
    
    func xmlPrasing(rssData: String) {
        // TODO: item und channel Instancen speichern  oder  direckt in das User Interface
        let regex = try! NSRegularExpression(pattern: "<item>", options: NSRegularExpression.Options.caseInsensitive)
        let range = NSMakeRange(0, rssData.count)
        var modifyedRssData = regex.stringByReplacingMatches(in: rssData, options: [], range: range, withTemplate: "⏸")
        
        var dataArray = modifyedRssData.split(separator: "⏸")
        var count = 0
        let praser = PraseXMLString.init()
        let channelTitle = praser.getItemInformations(source: String(dataArray[0]), type: "title")
        let channellink = praser.getItemInformations(source: String(dataArray[0]), type: "link")
        let channelDescription = praser.getItemInformations(source: String(dataArray[0]), type: "description")
        let language = praser.getItemInformations(source: String(dataArray[0]), type: "language ")
        let channelInstance = Channel.init(title: channelTitle, link: channellink, channelDescription: channelDescription, language: language)
        
        dataArray.remove(at: 0)
        for informations in dataArray{
            let title = praser.getItemInformations(source: String(informations), type: "title")
            let description = praser.getItemInformations(source: String(informations), type: "description")
            let link = praser.getItemInformations(source: String(informations), type: "link")
            
            let itemInstance = Item.init(title: title, link: link, itemDescription: description, pubDate: nil, category: nil, author: nil)
            count += 1
        }
        
    }
    
}
