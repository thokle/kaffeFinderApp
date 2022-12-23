//
//  LocalStorageService.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 06/09/2022.
//

import Foundation


public class  LocalStorageService {
    
    init (){
        
    }
 
    func saveUser(user: User) {
        
        UserDefaults.standard.set(user, forKey: "user")

    }
    
    func getUser() -> User
    {
        var person: User = User()
        do {
            if let savedperson = UserDefaults.standard.object(forKey: "user") as? Data {
                let decoder = JSONDecoder()
                if let loadPerson = try? decoder.decode(User.self, from: savedperson) {
                    person = loadPerson
                }
            }
            
        } catch let jsonerror {
            print(jsonerror.localizedDescription)
        }
        return person
    }
        
    func saveUserId(user: User) {
        UserDefaults.standard.set(user.id, forKey: "id")
    }
    
    func getUserId()-> Int {
        return  UserDefaults.standard.integer(forKey: "id")
    }
    
    func getUserName() -> String {
        return UserDefaults.standard.string(forKey: "username")!
    }
    
    func saveAddreseId(adrsse: Addresse) {
        UserDefaults.standard.set(adrsse.id, forKey: "address")
    }
    
    func getAddressId()-> Int {
        return UserDefaults.standard.integer(forKey: "address")
    }

    func setUserame(username: String) {
        UserDefaults.standard.set(username, forKey: "username")
    }
    
    func setEmail(email: String) {
        UserDefaults.standard.set(email, forKey: "e-mail")
    }
    
    func getEmail() -> String {
        return         UserDefaults.standard.string(forKey: "e-mail")!
    }
    
    func setLatitude(lat: Double){
        UserDefaults.standard.set(lat, forKey: "latitude")
    }
    
    func setLongitude(lng: Double){
        UserDefaults.standard.set(lng, forKey:  "longitude")
    }
    
    func getUserLatitude()->Double {
        return UserDefaults.standard.double(forKey: "latitude")
    }
    
    func getUserLongitude() -> Double {
        return UserDefaults.standard.double(forKey: "longitude")
    }
    
}   
