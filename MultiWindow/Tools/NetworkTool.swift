
//
//  NetworkTool.swift
//  Sougua
//
//  Created by zhishen－mac on 2018/4/8.
//  Copyright © 2018年 zhishen－mac. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
enum MethodType {
    case get
    case post
}
protocol NetworkToolProtocol {
    static func loadTitleData(completionHandler: @escaping (_ newTitles:Array<String>)->())
    static func loadHomePageCategoryButtonData(completionHandler: @escaping (_ categoryButtonModel:[CategoryButton])->())
    static func requestData(_ type : MethodType, URLString : String, parameters : [String : Any], finishedCallback :  @escaping (_ result : Any) -> ())
//    NetworkTools.requestData(.get, URLString: "http://httpbin.org/get") { (result) in
//    print(result)
//    }
//
//    NetworkTools.requestData(.post, URLString: "http://httpbin.org/post", parameters: ["name": "JackieQu"]) { (result) in
//    print(result)
//    }
}
extension NetworkToolProtocol{

    
}
struct NetworkTool: NetworkToolProtocol {
    static func requestData(_ type: MethodType, URLString: String, parameters: [String : Any], finishedCallback: @escaping (Any) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            finishedCallback(result)
        }
    }
    static func loadTitleData(completionHandler: @escaping (_ newTitles:Array<String>)->()){
        let titles = ["推荐","热门","新闻","段子","视频","搞笑","军事"]
        completionHandler(titles)
    }
    static func loadHomePageCategoryButtonData(completionHandler: @escaping (_ categoryButtonModel:[CategoryButton])->()){
        //        let titles = ["新闻","段子","视频","美图","贷款","小说","抢票","旅游","外卖","更多"]
        let jsonStr = """
 {
            "data":[
            {
            "title": "新闻",
            "imageurl": "新闻",
            "index": 0
            },
            {
            "title": "段子",
            "imageurl": "段子",
            "index": 1
            },
            {
            "title": "视频",
            "imageurl": "视频",
            "index": 2
            },
            {
            "title": "美图",
            "imageurl": "美图",
            "index": 3
            },
            {
            "title": "贷款",
            "imageurl": "贷款",
            "index": 4
            },
            {
            "title": "小说",
            "imageurl": "小说",
            "index": 5
            },
            {
            "title": "抢票",
            "imageurl": "抢票",
            "index": 6
            },
            {
            "title": "旅游",
            "imageurl": "旅游",
            "index": 7
            },
            {
            "title": "外卖",
            "imageurl": "外卖",
            "index": 8
            },
            {
            "title": "更多",
            "imageurl": "更多",
            "index": 9
            },
           {
            "title": "外卖",
            "imageurl": "外卖",
            "index": 10
            },
            {
            "title": "外卖",
            "imageurl": "外卖",
            "index": 11
            },
            {
            "title": "更多",
            "imageurl": "更多",
            "index": 12
            },
           {
            "title": "外卖",
            "imageurl": "外卖",
            "index": 13
            }
            ]
        }
"""
        
        //        if let model = CategoryButton.deserialize(from: jsonStr){
        //            print(model.title)
        //        }
        //
        //string 转 json
        let jsonData:Data = jsonStr.data(using: String.Encoding.utf8)!
        let json = try! JSON(data: jsonData)
        let resJson = json["data"].array
        var categoryBtns = [CategoryButton]()
        
        for item in resJson! {
            let cateButton = CategoryButton()
            if let title = item["title"].string{
                cateButton.title = title
                
            }
            if let indexbtn = item["index"].int{
                cateButton.index = indexbtn
                
            }
            if let imageUrl = item["title"].string{
                cateButton.imageUrl = imageUrl
                
            }
            print(cateButton)
            categoryBtns += [cateButton]
        }
        completionHandler(categoryBtns)
    }
    static func loadHomePageNewsData(completionHandler: @escaping (_ homePageNews:[HomePageNews])->()){
        
        let path = Bundle.main.path(forResource: "homepage", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try! Data(contentsOf: url)
        let jsonStr = String(data: data, encoding: String.Encoding.utf8)
        let json = try! JSON(data: data)
        guard json["result"] == "success" else { return }
        if let datas = json["data"].arrayObject{
            var homepageNews  = [HomePageNews]()
            homepageNews += datas.flatMap({HomePageNews.deserialize(from: $0 as? Dictionary)})
            completionHandler(homepageNews)
        }
        
        
        //print(obj as Any)
        //homepageNews += datas.flatMap({HomePageNews.deserialize(from: $0 as? Dictionary)})
        //        completionHandler(datas.flatMap({ HomePageNews.deserialize(from: $0.string) }))
        //        if let obj = HomePageNews.deserialize(from: jsonStr) {
        //            print(obj)
        //        }
        //        let json = try! JSON(data: Data(contentsOf: url))
        //        if json["result"].string == "success" {
        //            let dataList = json["data"].array
        //            print(dataList as Any)
        //        }
        //        completionHandler([])
    }
}
