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
    
    var articles: [Article]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchArticles()
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
                        let author = articleFromJSON["author"] as? String,
                        let desc = articleFromJSON["description"] as? String,
                        let url = articleFromJSON["url"] as? String,
                            let urlimage = articleFromJSON["urlToImage"] as? String {
                            
                            article.author = author
                            article.desc = desc
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
        cell.Description.text = self.articles?[indexPath.item].desc
        cell.Author.text = self.articles?[indexPath.item].author
        cell.ImgView.downloadImage(from: (self.articles?[indexPath.item].imageURL!)!)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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

