//
//  NetworkingManager.swift
//  AlamofireSwift
//
//  Created by Deniz Ata Eş on 6.01.2023.
//

import Foundation
import Alamofire

class NetworkingManager {
    private let url:String = "https://dog.ceo/api/breeds/list/all"
    public static var shared = NetworkingManager()
    func getDogList(completion: @escaping (Result<[String], Error>) -> Void){
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor:nil).response{
            (responseData) in
            guard let data = responseData.data
            else {return}
            var dogArr = [String]()
            do{
                let dogs = try JSONDecoder().decode(Dog.self, from: data)
                for item in dogs.message!.keys {
                    dogArr.append(item)
                }
                completion(.success(dogArr))
            }
            catch{
                completion(.failure(error))
            }
        }
    }
}
