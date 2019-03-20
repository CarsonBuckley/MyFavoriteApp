//
//  UserController.swift
//  MyFavoriteApp
//
//  Created by Carson Buckley on 3/20/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import Foundation

class UserController {
    
    //Shared Instance
    static var shared = UserController()
    private init () {}
    
    //Source of Truth <<<<<<<<<<<<<<<
    var users: [User] = []
    
    //Base URL
    let baseURL = URL(string: "https://favoriteapp-375c6.firebaseio.com")
    
    //MARK: - CRUD
    
    //GET Request (Read)
    func getUsers(completion: @escaping (Bool) -> Void) {
        
        
        //Created URL
        guard var url = baseURL else { completion(false) ; return }
        url.appendPathComponent("users")
        //https://favoriteapp-375c6.firebaseio.com
        url.appendPathExtension("json")
        //https://favoriteapp-375c6.firebaseio.com.json
        print(url)
        
        
        //Create URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        //Data Task + RESUME
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("There was an error retreiving the Data: \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            if let response = response {
                print(response)
            }
            guard let data = data else { completion(false) ; return }
            let decoder = JSONDecoder()
            do {
                let dictionaryOfUsers = try decoder.decode([String: User].self, from: data)
                var users: [User] = []
                for(_, value) in dictionaryOfUsers {
                    users.append(value)
                }
                self.users = users
                completion(true)
            } catch {
                print("There was an error decoding the Data \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
        }.resume()
    }
    
    //POST Request (Update)
    
    
}
