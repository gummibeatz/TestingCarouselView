//
//  WardrobeTableViewController.swift
//  TestingCarouselView
//
//  Created by Linus Liang on 1/24/16.
//  Copyright © 2016 Linus Liang. All rights reserved.
//

import UIKit

class WardrobeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .None
            tableView.backgroundColor = UIColor.blackColor()
        }
    }
    
    var isDropped = [
        true,
        true,
        true,
        true
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }

    // MARK: - Table view data source
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return isDropped.count
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if !isDropped[indexPath.section] {
            cell = tableView.dequeueReusableCellWithIdentifier("carouselCellCompressed", forIndexPath: indexPath)
            (cell as! CarouselCompressedTableViewCell).delegate = self

        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("carouselCell", forIndexPath: indexPath) as! CarouselTableViewCell
            (cell as! CarouselTableViewCell).delegate = self
        }
        cell!.tag = indexPath.section
        return cell!
    }

     func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }

     func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    // MARK: - Table view delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return isDropped[indexPath.section] ? 150 : 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        view.backgroundColor = UIColor.blackColor()
        return view
    }
}

extension WardrobeViewController: CarouselCompressedTableViewCellDelegate, CarouselTableViewCellDelegate {
    // MARK: - tablecell delegates
    func toggleDropdown(idx: Int) {
        isDropped[idx] = !isDropped[idx]
        self.tableView.reloadSections(NSIndexSet(index: idx), withRowAnimation: UITableViewRowAnimation.Fade)
    }
}
