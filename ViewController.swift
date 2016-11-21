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
        
        let identifer:String = "tableviewcell"
        
        tableView.register(UINib(nibName: identifer, bundle: nil), forCellReuseIdentifier: identifer)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifer) as! myTableViewCell
    
        cell.title.text = "\(indexPath.row)"
        return cell
    }
    
   
   
}

