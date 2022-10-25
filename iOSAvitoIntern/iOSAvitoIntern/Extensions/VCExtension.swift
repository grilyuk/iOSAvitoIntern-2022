//
//  Extension.swift
//  iOSAvitoIntern
//
//  Created by Григорий Данилюк on 25.10.2022.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource {
    
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
}

extension ViewController: UITableViewDelegate {
    
    //MARK: header for tableview
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
