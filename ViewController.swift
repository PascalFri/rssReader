//
//  ViewController.swift
//  Rss_Reader
//
//  Created by Pascal Fritz on 05.01.19.
//

import Cocoa

class ViewController: NSViewController {

    
    // the button load
    @IBAction func load(_ sender: NSButton) {
        reloadFileList()
    }
    
    
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    var channelList: [Channel]?
    var feedCount = 0
    var itemCount  = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    fileprivate func loadData() {
        
        let loadData = LoadData.init()
        // create an url and load the data from the url
        channelList = []
        
        var urlList: [String] = []
        urlList.append("http://newsfeed.zeit.de/index")
        urlList.append( "https://www.bundesrat.de/SiteGlobals/Functions/RSSFeed/RSSGenerator_Announcement.xml;jsessionid=4881716808CECDEEFC70C48AFD848824.1_cid382?nn=4352850")
        urlList.append( "https://www.bfarm.de/SiteGlobals/Functions/RSSFeed/DE/Pressemitteilungen/RSSNewsfeed.xml;jsessionid=F3F274332A63B600EE874BB344A4AC69.1_cid329")
        urlList.append( "http://feeds.feedburner.com/DLR_top")
        urlList.append("https://www.nasa.gov/rss/dyn/breaking_news.rss")
        
        for linkString in urlList {
            guard let url = URL(string: linkString) else {
                print("could not create url to: " + linkString)
                return
            }
            
            guard let rssData = loadData.getRssData(url: url) else{
                print("could not load data")
                continue
            }
            channelList?.append(rssData)
        }
        
        reloadFileList()
    }
    
    override var representedObject: Any? {
        didSet {
            reloadFileList()
        }
    }
    
    func reloadFileList() {
        tableView.reloadData()
    }
    
}
extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.channelList?.count ?? 0
    }
}

extension ViewController: NSTableViewDelegate {

    fileprivate enum CellIdentifiers {
        static let FeedCell = "FeedCellID"
        static let EinträgeCell = "EinträgeCellID"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text: String = ""
        var cellIdentifier: String = ""
        
        //  set the title or the Item for an channel
        if tableColumn == tableView.tableColumns[0] {
            text = channelList![feedCount].title
            cellIdentifier = CellIdentifiers.FeedCell
            feedCount+=1
            
        } else if tableColumn == tableView.tableColumns[1] && feedCount < channelList?.count ?? 0 {
            text = channelList![feedCount].getItems()[itemCount].getTitle()
            cellIdentifier = CellIdentifiers.EinträgeCell
            itemCount+=1
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
        
    }
    
}
