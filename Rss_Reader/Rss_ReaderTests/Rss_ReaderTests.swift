//
//  Rss_ReaderTests.swift
//  Rss_ReaderTests
//
//  Created by Pascal Fritz on 05.01.19.
//

import XCTest
@testable import Rss_Reader

class Rss_ReaderTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let source = """
>News.1.31298</guid>
      <title>International Forum for Aviation Research</title>
      <description>&lt;img align="right" alt="" src="https://www.dlr.de/dlr/resourceimage.aspx?raid=327157"&gt;Vom 27. bis 29. November 2018 trafen sich auf Einladung der führenden russischen Foriskussionsplattform für die Luftfahrtforschung.&lt;img src="http://feeds.feedburner.com/~r/DLR_top/~4/lylNmOy7Lr8" height="1" width="1" alt=""/&gt;</description>
      <link>http://feedproxy.google.com/~r/DLR_top/~3/lylNmOy7Lr8/</link>
"""
        let praser = PraseXMLString.init()
        
        var result = praser.getItemInformations(source: source, type: "link")
        XCTAssertEqual("http://feedproxy.google.com/~r/DLR_top/~3/lylNmOy7Lr8/", result)
        result = praser.getItemInformations(source: source, type: "description")
        XCTAssertEqual("""
&lt;img align="right" alt="" src="https://www.dlr.de/dlr/resourceimage.aspx?raid=327157"&gt;Vom 27. bis 29. November 2018 trafen sich auf Einladung der führenden russischen Foriskussionsplattform für die Luftfahrtforschung.&lt;img src="http://feeds.feedburner.com/~r/DLR_top/~4/lylNmOy7Lr8" height="1" width="1" alt=""/&gt;
""", result)
        
        result = praser.getItemInformations(source: source, type: "title")
        XCTAssertEqual("International Forum for Aviation Research", result)
        
    }
    
    func testDetails() {
        let loader = LoadData.init();
        let rssData = loader.getRssData(url: URL(string: "http://newsfeed.zeit.de/index")!)
        
    }

    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
