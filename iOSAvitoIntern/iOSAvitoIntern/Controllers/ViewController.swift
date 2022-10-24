//
//  ViewController.swift
//  iOSAvitoIntern
//
//  Created by Григорий Данилюк on 23.10.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    
    //MARK: quantity rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.company.employees.count ?? 0
    }
    
    //MARK: custom cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainTableViewCell
        cell.nameLabel.text = result?.company.employees[indexPath.row].name
        cell.phoneLabel.text = result?.company.employees[indexPath.row].phoneNumber
        cell.skillsLabel.text = {
            var text = ""
            let arraySkills = result?.company.employees[indexPath.row].skills ?? [""]
            for skill in arraySkills {
                text.append("\(skill), ")
            }
            return String(text.dropLast(2))
        }()
        return cell
    }
    
    //MARK: height for cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    //MARK: header for uitable
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 10, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            label.text = result?.company.name
            label.font = .systemFont(ofSize: 25)
            label.textColor = .systemBlue
            
            headerView.addSubview(label)
            
            return headerView
        }
}

