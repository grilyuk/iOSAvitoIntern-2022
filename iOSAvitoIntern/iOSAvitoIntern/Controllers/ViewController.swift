//
//  ViewController.swift
//  iOSAvitoIntern
//
//  Created by Григорий Данилюк on 23.10.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let cellId = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    //MARK: create TableView
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        return table
    }()
    
    //MARK: quantity rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //MARK: custom cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainTableViewCell
        cell.nameLabel.text = ""
        cell.phoneLabel.text = ""
        cell.skillsLabel.text = ""
        return cell
    }
    
    //MARK: height for cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

