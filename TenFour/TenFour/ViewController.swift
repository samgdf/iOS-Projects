//
//  ViewController.swift
//  TenFour
//
//  Created by Sam Goldfield on 4/4/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellSpacingHeight: CGFloat = 5
    let cellReuseIdentifier = "cell"
    
    var articles: [Article]? = []
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
                
        refreshControl.tintColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        refreshControl.backgroundColor = UIColor(red:0.09, green:0.09, blue:0.09, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Kicking off...", attributes: [NSForegroundColorAttributeName: refreshControl.tintColor])
        
        refreshControl.addTarget(self, action: #selector(ViewController.reloadData), for: UIControlEvents.valueChanged)
        
        if #available(iOS 10.0, *) {
        tableView.refreshControl = refreshControl
        } else {
        tableView.addSubview(refreshControl)
        }
    }
    
    func reloadData() {
        fetchArticles()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func fetchArticles(){
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=four-four-two&sortBy=top&apiKey=d2862baa27de46009dd2a17391f176e6" )!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data,response,error) in
            
            if(error != nil){
                print(error!)
                return
        }
            
            self.articles = [Article]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let articlesFromJSON = json["articles"] as? [[String : AnyObject]] {
                    for articleFromJSON in articlesFromJSON {
                        
                        let article = Article()
                        
                        if let title = articleFromJSON["title"] as? String,
                        let url = articleFromJSON["url"] as? String,
                            let urlimage = articleFromJSON["urlToImage"] as? String {
                            
                            article.headline = title
                            article.url = url
                            article.imageURL = urlimage
                            
                        }
                        
                        self.articles?.append(article)
                    }
                }
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
        }
        
            task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell

        cell.Title.text = self.articles?[indexPath.item].headline
        cell.ImgView.downloadImage(from: (self.articles?[indexPath.item].imageURL!)!)
        cell.ImgView.layer.cornerRadius = 3
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webvc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebViewViewController
        
        webvc.url = self.articles?[indexPath.item].url
        
        self.present(webvc, animated: true, completion: nil)
    }
}

extension UIImageView {
    func downloadImage(from url: String) {
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data,response,error) in
            
            if (error != nil) {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        
        task.resume()
        
    }
}

