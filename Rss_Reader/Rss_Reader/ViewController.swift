//
//  ViewController.swift
//  Rss_Reader
//
//  Created by Pascal Fritz on 05.01.19.
//

import Cocoa

class ViewController: NSViewController {

    @IBAction func load(_ sender: NSButton) {
        let loadData = LoadData.init()
        let urlString: String = "http://newsfeed.zeit.de/index"
       // let urlString: String = "http://www.spiegel.de/schlagzeilen/tops/index.rss"
        //let urlString: String = "https://www.bundesrat.de/SiteGlobals/Functions/RSSFeed/RSSGenerator_Announcement.xml;jsessionid=4881716808CECDEEFC70C48AFD848824.1_cid382?nn=4352850"
        //let urlString: String = "https://www.bfarm.de/SiteGlobals/Functions/RSSFeed/DE/Pressemitteilungen/RSSNewsfeed.xml;jsessionid=F3F274332A63B600EE874BB344A4AC69.1_cid329"
        //let urlString: String = "http://feeds.feedburner.com/DLR_top"
        //let urlString: String = "https://www.nasa.gov/rss/dyn/breaking_news.rss"
        //let urlString: String = "https://www.tagesschau.de/xml/rss2"
        
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        loadData.getRssData(url: url)
    }
        
    @IBOutlet weak var label: NSTextField!
    @IBOutlet var scrollView: NSScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

