//
//  ViewController.swift
//  JDMonkeyScrollBar
//
//  Created by jamesdouble on 2016/11/18.
//  Copyright © 2016年 jamesdouble. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    var JD:JDMonkeyScrollBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
       self.tableview.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidLayoutSubviews() {
        print(#function)
        JD = JDMonkeyScrollBar(scrollview: self.tableview)

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.rowHeight))
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: 100, height: tableView.rowHeight))
        label.text = "\(indexPath.row)"
        cell.addSubview(label)
        return cell
    }
    
   
   
}

