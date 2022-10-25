//
//  ViewController.swift
//  iOSAvitoIntern
//
//  Created by Григорий Данилюк on 23.10.2022.
//

import UIKit

class ViewController: UIViewController {

    var result: ParseModel?

    let response = Response()
    
    let cellId = "cell"
    let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    
    //MARK: viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        response.request(url: urlString) { [weak self] (outcome) in
            switch outcome {
            case .success(let response):
                self?.result = response
                self?.tableView.reloadData()
            case .failure(_):
                print("SomeError")
            }
        }
    }
    
    //MARK: create TableView
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        return table
    }()
}

