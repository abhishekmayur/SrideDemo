//
//  Parser.swift
//  NewFeed
//
//  Created by Abhishek Dhamdhere on 12/07/21.
//

import Foundation
import SwiftyJSON
import AlamofireSwiftyJSON
import Alamofire
class Parser: NSObject {
    //MARK: Singlton class
    static let sharedInastance = Parser()
    //MARK: Parser Method
    func parseNewsList(data:JSON) -> [News] {
        var news:[News] = []
        let jsonResponce = data
        jsonResponce["articles"].array?.forEach({ (item)in
            let nws = News(content: item["content"].stringValue, title: item["title"].stringValue, author: item["author"].stringValue, id: item["source"]["id"].stringValue, name: item["source"]["name"].stringValue, urlToImage: item["urlToImage"].stringValue, url: item["url"].stringValue, descriptions: item["description"].stringValue, publishedAt: item["publishedAt"].stringValue)
            news.append(nws)
        })
        return news
    }
}
