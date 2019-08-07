//
//  SwipeViewController.swift
//  MadeUStaffDone
//
//  Created by Nazar Petruk on 06/08/2019.
//  Copyright © 2019 Nazar Petruk. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: tableView Datasource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.updateModel(indexPath: indexPath)
        }
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    
    func updateModel(indexPath: IndexPath){
        // func is overrided in CategoryViewController 
    }
}
