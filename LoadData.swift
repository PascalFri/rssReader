//
//  LoadData.swift
//  Rss_Reader
//
//  Created by Pascal Fritz on 08.01.19.
//

import Cocoa
import os.log


class LoadData: NSObject {

    var rssChannel: Channel?
    
    fileprivate func makeHttpRequest(_ url: URL)  -> String{
        // Set up the URL request
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let group = DispatchGroup()
        group.enter()
        
        var urlData = ""
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
         
            // check for any errors
            guard error == nil else {
                print("error calling GET on a Rss-Feed")
                print(error!)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            // make sure we got data
            guard data != nil else {
                print("Error: did not receive data")
                return
            }
            
            
            urlData = String(data: data!, encoding: .utf8)!
            group.leave()
        }
        task.resume()
        
        // Wait until the loading has finished
        group.wait()
        
        
        return urlData
    }
    
    func getRssData(url: URL) -> Channel?{
        
        let urlData = makeHttpRequest(url)
        if urlData == "" {
            print("missing Data")
        } else {
            rssChannel = xmlPrasing(rssData: urlData)
        }
        
        
        if rssChannel == nil{
            print("something went wrong2")
        }
    
        return rssChannel
    }
    
    
    
    func xmlPrasing(rssData: String) -> Channel{
        // TODO: item und channel Instancen speichern  oder  direckt in das User Interface
        let regex = try! NSRegularExpression(pattern: "<item>", options: NSRegularExpression.Options.caseInsensitive)
        let range = NSMakeRange(0, rssData.count)
        
        let modifyedRssData = regex.stringByReplacingMatches(in: rssData, options: [], range: range, withTemplate: "⏸")
        var dataArray = modifyedRssData.split(separator: "⏸")
        var count = 0
        let praser = PraseXMLString.init()
        let channelTitle = praser.getItemInformations(source: String(dataArray[0]), type: "title")
        let channellink = URL(string: praser.getItemInformations(source: String(dataArray[0]), type: "link"))!
        let channelDescription = praser.getItemInformations(source: String(dataArray[0]), type: "description")
        let language = praser.getItemInformations(source: String(dataArray[0]), type: "language ")
        
        var items: [Item] = []
        dataArray.remove(at: 0)
        getInformations(dataArray, praser, &items, &count)
        let data = Channel.init(title: channelTitle, link: channellink, channelDescription: channelDescription, language: language,items: items )
        
        return data;
    }
    
    fileprivate func getInformations(_ dataArray: [String.SubSequence], _ praser: PraseXMLString, _ items: inout [Item], _ count: inout Int) {
        for informations in dataArray{
            let title = praser.getItemInformations(source: String(informations), type: "title")
            let description = praser.getItemInformations(source: String(informations), type: "description")
            let link = praser.getItemInformations(source: String(informations), type: "link")
            
            let item = Item.init(title: title, link: link, itemDescription: description, pubDate: nil, category: nil, author: nil)
            items.append(item)
            count += 1
        }
    }
    
    //MARK: Private Methods
    private func saveRss(){
        print("i have to save something")
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(rssChannel, toFile: Channel.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("RssChannel successfully saved.", log: OSLog.default, type: .debug)
        }else{
            os_log("Failed to save RssChannel...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadRss() -> Channel?{
        print("I have to load something")
        //return NSKeyedUnarchiver.unarchivedObject(ofClass: Channel.self, from: Channel.ArchiveURL.path)
        return NSKeyedUnarchiver.unarchiveObject(withFile: Channel.ArchiveURL.path) as? Channel
    }
}


