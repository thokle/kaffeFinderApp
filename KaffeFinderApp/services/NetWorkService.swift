//
//  NetWorkService.swift
//  findfoodtruck
// http://ad-scoop.com
//  Created by Thomas Kleist on 03/09/2022.
//

import Foundation


public class NetWorkService: NSObject {
    
    //ad-scoop.com
    var ip = "http://ad-scoop.com"
    var port = "8889"
    
    func getAllOpenSalePlaces(complietion: @escaping (Result<[SalePlace]?, Error>)->Void) {
        guard let url = URL(string: "\(ip):\(port)/sale/allclose") else {
            print("Invalid Url"); return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            if let error = error {
                complietion(.failure(error.localizedDescription as! Error))
            }
            do {
                let saleplaces = try JSONDecoder().decode([SalePlace].self, from: data!)
                
                DispatchQueue.main.async {
                    complietion(.success(saleplaces))
                }
            }catch let error {
                complietion(.failure(error))
            }
        }.resume()
    }
    
    
    func addUser( user: User, completion: @escaping (Result<User?, Error>)->Void){
        guard let url = URL(string: "\(ip):\(port)/user/create") else {
            print("Invalid url"); return
        }
        var request: URLRequest
        do {
            request = URLRequest(url: url);
            let body = try JSONEncoder().encode(user)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpMethod = "POST"
            request.httpBody = body
        } catch let error {
            print("Error \(error.localizedDescription)")
        }
        
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            do
            {
                let res = try JSONDecoder().decode(User.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(res))
                }
            }catch let json {
                print(json.localizedDescription)
                // completion(.failure(json.localizedDescription as! Error ))
            }
        }.resume()
    }
    
    func addAddress(userAddresse: UserAddress, completion: @escaping (Result<Addresse?, Error>)->Void){
        guard let url = URL(string: "\(ip):\(port)/address/addAddress") else {
            print("Invalid url"); return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = try! JSONEncoder().encode(userAddresse)
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        
        request.httpBody = body
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                completion(.failure(error.localizedDescription as!Error))
                
            }
            
            do {
                
                let res =  try JSONDecoder().decode(Addresse.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(res))
                }
            } catch let json {
                print(json.localizedDescription)
                completion(.failure(json.localizedDescription as! Error))
            }
        }.resume()
        
        
    }
    
    func addSalePlace( saleplace: AddressSalePlace , completion: @escaping  (Result<SalePlace?, Error>)->Void) {
        guard let url = URL(string: "\(ip):\(port)") else {
            print("Invalid url"); return
        }
        
        var request = URLRequest(url: url)
        let body = try! JSONEncoder().encode(saleplace)
        request.httpBody = body
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) {
            (data, response , error) in
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
            }
            
            do {
                let res = try JSONDecoder().decode(SalePlace.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(res))
                }
            } catch let json {
                completion(.failure(json.localizedDescription as! Error))
            }
        }
    }
    
    func addGroocery(groocery: SalePlaceGroocery, completion: @escaping (Result<Groocery?, Error>)->Void){
        guard let url = URL(string: "\(ip):\(port)/user/logim") else {
            print("Invalid Url"); return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = try! JSONEncoder().encode(groocery)
        request.httpBody = body
        URLSession.shared.dataTask(with: request) {
            (data, respose ,error) in
            
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
            }
            do {
                let res = try JSONDecoder().decode(Groocery.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(res))
                }
                
            } catch let json {
                completion(.failure(json.localizedDescription as! Error))
            }
        }.resume()
        
    }
    
    func openShop(id: Int, completion: @escaping (Result<Bool?, Error>)->Void){
        guard let url = URL(string: "\(ip):\(port)") else {
            print("Invalid url"); return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
            }
            do {
                let res = try JSONDecoder().decode(Bool.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(res))
                }
            }catch let jsonError {
                completion(.failure(jsonError.localizedDescription as! Error))
            }
            
        }
    }
    
    func closeShop(id: Int, completion: @escaping (Result<Bool?, Error>)->Void) {
        guard let url = URL(string: "\(ip):\(port)") else {
            print("Invalid url"); return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request)
        { (data, response , error) in
            
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
            }
            
            do {
                let res = try JSONDecoder().decode(Bool.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(res))
                }
            } catch let json {
                completion(.failure(json.localizedDescription as! Error))
            }
        }
    }
    
    func logion(username: String, password: String, completion: @escaping (Result<User?,Error>)->Void) {
        guard let url = URL(string: "\(ip):\(port)/user/login") else {
            print("Invalid URL"); return
        }
        var request = URLRequest(url: url)
        request.setValue(username, forHTTPHeaderField: "username")
        request.setValue(password, forHTTPHeaderField: "password")
        request.httpMethod = "Get"
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error.localizedDescription as! Error))
            }
            do {
                let res = try JSONDecoder().decode(User.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(res))
                }
            } catch let jsonError {
                completion(.failure(jsonError.localizedDescription as! Error))
            }
        }.resume()
    }
    
    func getAddresssFromEmail(email: String, complietion: @escaping (Result<[Addresse]?, Error>)->Void) {
        guard let url = URL(string:  "\(ip):\(port)/address/user") else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(email, forHTTPHeaderField: "email")
        URLSession.shared.dataTask(with:request) {
            (data,response, error) in
            if let error = error {
                complietion(.failure(error.localizedDescription as! Error))
            }
            do{
                let res = try JSONDecoder().decode([Addresse].self, from: data!)
                DispatchQueue.main.async {
                    complietion(.success(res))
                }
            } catch let json {
                complietion(.failure(json.localizedDescription as! Error))
            }
            
        }.resume()
        
        
    }
    
    func addSalePlaceToUser(salePlace: SalePlace, id: String, completion: @escaping (Result<SalePlace, Error>)->Void) {
        guard let url = URL(string: "\(ip):\(port)/user/addsaleplace/\(id)") else {
             return;
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(salePlace)
        URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            do {
                var res = try JSONDecoder().decode(SalePlace.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(res))
                }
    
            }catch let jsonError {
                completion(.failure(jsonError.localizedDescription as! Error))
            }
        }.resume()
        
        
    }
    
    func getSalePlacesByUserName(userName: String, completion: @escaping (Result<[SalePlace],Error>)-> Void){
        guard let url = URL(string: "\(ip):\(port)/user/saleplaces/") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(userName, forHTTPHeaderField: "username")

        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) {
            (data,response, error ) in
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
            }
            do {
                var res = try JSONDecoder().decode([SalePlace].self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(res))
                    
                }
               
            }catch let jsonErroo {
                completion(.failure(jsonErroo.localizedDescription as! Error))
            }
        }.resume()
    }
    
    func getAddressByUsername(usermame:String , completion: @escaping (Result<[Addresse], Error>)->Void) {
        guard let url = URL(string: "") else {
            return
        }
    }
    
    func getUserByEmail(email:String, completion: @escaping (Result<User,Error>)->Void){
        guard let url = URL(string: "\(ip):\(port)/user/getUserByEmail/\(email)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                completion(.failure(error.localizedDescription as! Error))
            }
            do {
                let res = try JSONDecoder().decode(User.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(res))
                }
            } catch let error {
                completion(.failure(error.localizedDescription as!  Error))
            }
        }}
    


}

