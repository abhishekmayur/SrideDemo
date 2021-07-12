//
//  News.swift
//  NewFeed
//
//  Created by Abhishek Dhamdhere on 12/07/21.
//

import Foundation
//MARK: Model class
class News:NSObject {
    var content :String
    var title :String
    var author :String
    var id :String = ""
    var name :String = ""
    var urlToImage :String
    var url:String = ""
    var descriptions:String = ""
    var publishedAt:String = ""
    
    init(content:String,title:String,author:String,id:String,name:String,urlToImage:String,url:String,descriptions:String,publishedAt:String) {
        self.content = content
        self.title = title
        self.author = author
        self.id = id
        self.name = name
        self.urlToImage = urlToImage
        self.descriptions = descriptions
        self.publishedAt = publishedAt
        self.url = url
    }
    
}
