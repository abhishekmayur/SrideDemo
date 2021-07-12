//
//  ViewController.swift
//  NewFeed
//
//  Created by Abhishek Dhamdhere on 12/07/21.
//

import UIKit
import SDWebImage
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var newsArray:[News] = []
    
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
        //MARK:- Register XIB Cell
        self.tableView.register(UINib.init(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        // MARK:-  method Call
        newsApi(q:"apple", from: "2021-07-1", to: "2021-07-11",apiKey:"e2436911e93944d099d7499f2b417c6e")
    }
    // MARK:- newsApi method Declaration
    func newsApi(q:String,from:String,to:String,apiKey:String)
    {
        self.activityIndicator.startAnimating()
        let param = ["q":q,"from":from,"to":to,"apiKey":apiKey] as? [String : AnyObject]
        
        let api:APIEngine = APIEngine()
        api.newsFeedAPI(param:param!){ responseObject, error in
            
            switch responseObject?.result  {
            case .success(let JSON)?:
                print("Success with JSON: \(JSON)")
                let jsonResponse = JSON
                
                if (jsonResponse["status"].stringValue == "ok") {
                    let parse:Parser = Parser()
                    self.newsArray = parse.parseNewsList(data: JSON)
                    print("self.newsArray\(self.newsArray)")
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
                else
                {
                    print("status false")
                    self.activityIndicator.stopAnimating()
                }
            case.failure(let error)?:
                print("error: \(error)")
                self.activityIndicator.stopAnimating()
                
            case .none:
                print("error: ")
                self.activityIndicator.stopAnimating()
            }
        }
    }
    // MARK:- TableView Datasource and Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath)as!NewsTableViewCell
        let temp = self.newsArray[indexPath.row]
        cell.titleLabel.text = temp.title
        cell.descriptionLabel.text = temp.descriptions
        cell.newsImageView.sd_setImage(with: URL(string:"\(temp.urlToImage)"), placeholderImage: UIImage(named: "profile"))
        cell.newsImageView.layer.cornerRadius = cell.newsImageView.frame.height/2
        cell.newsImageView.clipsToBounds = true
        cell.newsImageView.contentMode = .scaleAspectFill
        viewshadow(view: cell.cardView)
        viewshadow(view: cell.contentView)
        
        return cell
        
    }
    
}

