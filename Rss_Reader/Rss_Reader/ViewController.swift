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
        
        
        
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        loadData.getRssData(url: url)
    }
        
    
    @IBOutlet weak var label: NSTextField!
    
    
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

