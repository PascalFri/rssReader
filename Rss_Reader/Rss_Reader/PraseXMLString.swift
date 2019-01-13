//
//  PraseXMLString.swift
//  Rss_Reader
//
//  Created by Pascal Fritz on 11.01.19.
//

import Cocoa

class PraseXMLString: NSObject {

    func getItemInformations(source: String, type: String) -> String {
        var content = ""
        if source.contains(type) {
            
            // in the source the Substring with regex-pattern willbe relplaced by 😀
            var regex = try! NSRegularExpression(pattern: "\\/" + type, options: NSRegularExpression.Options.caseInsensitive)
            var range = NSMakeRange(0, source.count)
            var modifyedSource = regex.stringByReplacingMatches(in: source, options: [], range: range, withTemplate: "☹️")
            
            regex = try! NSRegularExpression(pattern: type, options: NSRegularExpression.Options.caseInsensitive)
            range = NSMakeRange(0, modifyedSource.count)
            modifyedSource = regex.stringByReplacingMatches(in: modifyedSource, options: [], range: range, withTemplate: "😀")
            
            // the 😀 will be the place to cut the and return the betwen the 😀> and <☹️
            // the result will be returned
            var start = modifyedSource.firstIndex(of: "😀")
            var end = modifyedSource.firstIndex(of: "☹️")
            start = modifyedSource.index(after: start!)
            start = modifyedSource.index(after: start!)
            end = modifyedSource.index(before: end!)
            //end = modifyedSource.index(before: end!) 
            let rangeSubstring = start!..<end!
            content.append(String(modifyedSource[rangeSubstring]))
        }
        return content
    }
}
