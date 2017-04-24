//
//  GoalsViewViewController.swift
//  TenFour
//
//  Created by Sam Goldfield on 4/19/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import UIKit

class GoalsViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellSpacingHeight: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*fetchGoals()*/
    }
    
   /* func fetchGoals() {
        let urlRequest = URLRequest(url: URL(string: "https://www.reddit.com/r/soccer/.json")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if(error != nil){
                print(error!)
                return
            }*/
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as! GoalCell
                
                return cell
            }
            
            func numberOfSections(in tableView: UITableView) -> Int {
                return 1
            }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 0
            }
}
            
/*            self.articles = [Article]()
            
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
    } */
