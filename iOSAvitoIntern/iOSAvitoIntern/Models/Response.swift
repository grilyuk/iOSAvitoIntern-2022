//
//  Response.swift
//  iOSAvitoIntern
//
//  Created by Григорий Данилюк on 24.10.2022.
//

import Foundation

final class Response {
    
    let cache = CacheData()
    
    func request(url: String, completion: @escaping (Result<ParseModel, Error>) -> Void) {
        //MARK: check cache timer
        if cache.killTimerData(key: "TimeSaved") {
            //MARK: let's URLSession
            guard let urlCorrect = URL(string: url) else { return }
            URLSession.shared.dataTask(with: urlCorrect) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode == 200 {
                        } else {
                            completion(.failure(response as! Error))
                        }
                    }
                    guard let data = data else { return }
                    do {
                        var decodeData = try JSONDecoder().decode(ParseModel.self, from: data)
                        decodeData.company.employees.sort {$0.name.lowercased() < $1.name.lowercased()}
                        self.cache.saveData(data, key: "DataSaved")
                        self.cache.timeDate(Date(), key: "TimeSaved")
                        completion(.success(decodeData))
                    } catch let errorJSON {
                        completion(.failure(errorJSON))
                    }
                }
            }.resume()
        } else {
            //MARK: reading from userdefaults
            do {
                guard let data = cache.getData(key: "DataSaved") else { return }
                var decodeData = try JSONDecoder().decode(ParseModel.self, from: data)
                cache.saveData(data, key: "DataSaved")
                decodeData.company.employees.sort {$0.name.lowercased() < $1.name.lowercased()}
                completion(.success(decodeData))
            } catch let smthWrong {
                completion(.failure(smthWrong))
            }
        }
    }
}
