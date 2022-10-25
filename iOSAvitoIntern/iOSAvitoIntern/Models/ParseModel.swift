//
//  ParseModel.swift
//  iOSAvitoIntern
//
//  Created by Григорий Данилюк on 23.10.2022.
//

import Foundation

struct ParseModel: Codable {
    var company: Company
}

struct Company: Codable {
    var name: String
    var employees: [Employee]
}

struct Employee: Codable {
    
    var name: String
    var phoneNumber: String
    var skills: [String]
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
