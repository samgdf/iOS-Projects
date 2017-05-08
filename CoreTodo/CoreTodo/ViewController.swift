//
//  ViewController.swift
//  CoreTodo
//
//  Created by Sam Goldfield on 5/3/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableVie: UITableView!
    
    var tasks: [Task] = []
    var filteredTasks = [Task]()
    var playerController = AVPlayerViewController()
    var player: AVPlayer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVie.dataSource = self
        tableVie.delegate = self
        filteredTasks = tasks
        
        setupTitle()
        
        let videoString: String? = Bundle.main.path(forResource: "truck", ofType: ".mp4")
        
        if let url = videoString {
            let videoURL = NSURL(fileURLWithPath: url)
            
            self.player = AVPlayer(url: videoURL as URL)
            self.playerController.player = self.player
        }
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableVie.tableHeaderView = searchController.searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //MARK GET DATA
        getData()
        
        //MARK RELOAD TABLEVIE
        tableVie.reloadData()
    }

    @IBAction func playVideo(_ sender: Any) {
        self.present(self.playerController, animated: true, completion: {
            self.playerController.player?.play()
        })
    }
    
    private func setupTitle() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "runn"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 36, height: 20)
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let task = filteredTasks[indexPath.row]
        
        if task.isImportant {
            cell.textLabel?.text = "😧 \(filteredTasks[indexPath.row].name!)"
        } else {
            cell.textLabel?.text = filteredTasks[indexPath.row].name!
        }
        
       return cell
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            filteredTasks = try context.fetch(Task.fetchRequest())
        } catch {
            print("Fetch failed")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete {
            
            let task = filteredTasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
            filteredTasks = try context.fetch(Task.fetchRequest())
            } catch {
                print("Fetch failed")
            }
            tableVie.reloadData()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            filteredTasks = tasks
        } else {
            filteredTasks = tasks.filter( {($0.name?.lowercased().contains(searchController.searchBar.text!.lowercased()))!} )
        }
    }

}
