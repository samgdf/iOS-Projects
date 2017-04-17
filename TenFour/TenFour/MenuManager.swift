//
//  MenuManager.swift
//  TenFour
//
//  Created by Sam Goldfield on 4/7/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import UIKit

class MenuManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let coverView = UIView()
    let menuTableView = UITableView()
    let arrayOfSources = ["A", "B", "C", "S"]
    
    public func openMenu() {
        if let window = UIApplication.shared.keyWindow {
            coverView.frame = window.frame
            coverView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            coverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissMenu)))
            
            let height: CGFloat = 100
            let y = window.frame.height - height
            
            menuTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            window.addSubview(coverView)
            
            
            UIView.animate(withDuration: 0.5, animations: {
                self.coverView.alpha = 1
            })
        }
    }
    
    public func dismissMenu() {
        UIView.animate(withDuration: 0.25, animations: {
            self.coverView.alpha = 0
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as UITableViewCell
    cell.textLabel?.text = arrayOfSources[indexPath.item]
    return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override init() {
        super.init()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        menuTableView.isScrollEnabled = false
        menuTableView.bounces = false
        
    }

}
