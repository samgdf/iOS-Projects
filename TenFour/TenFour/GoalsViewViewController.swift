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
      /* fetchGoals() */
    }
    
    /*
    func fetchGoals(){
        let urlRequest = URLRequest(url: URL(string: "https://www.reddit.com/r/soccer/.json")!)
    }
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        if error != nil {
            print(error)
        }
        if let redditSub = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let dataDic = redditSub["data"] as? [String:Any],
                    let children = dataDic["children"] as? [[String:Any]] {
                        
                        for child in children {
                            if let name = child["name"] as? String {
                                names.append(name)
                            }
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            task.resume()
        
    } catch let error {
        print(error)
    }
    */
    
    
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
