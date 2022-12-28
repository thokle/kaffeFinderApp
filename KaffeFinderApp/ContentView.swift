//
//  ContentView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 03/09/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var network = NetWorkService()

    @State var username:String = ""
    @State var password:String = ""
    @State var loginSuccess: Bool = false
    @State var userIsNotLoggedIn: Bool = false
    @ObservedObject var loginObject: LoginObservable = LoginObservable()
  
    var body: some View {
        
        TabView {
           
            if(!loginSuccess){
           
                VStack {
                    Form {
                        TextField("Username", text: $username).padding(3).backgroundStyle(.mint)
                        SecureField("Password", text: $password).padding(3)
                        HStack {
                            Button(action: Login){
                                Text("Login")
                            }.alert( "Failed to Login", isPresented: $userIsNotLoggedIn) {
                                Text("Wrong credentials")
                            }.buttonStyle(.bordered)
                            Button(action: cancel) {
                                Text("Cancel")
                            }.buttonStyle(.borderedProminent)
                        }
                    }
                }.tabItem {
                    Label("Logon", systemImage: "key")
                }
                UserView().tabItem {
                    Label("Create User", systemImage: "person")
                    
                }
                KortView().tabItem {
                    Label("Map", systemImage: "map")
                }
                }
         
            if(loginSuccess){
              
                    Button(action: logOut){
                        Text("Logout")
                          
                        
                    }.tabItem {
                        Label("Logout", systemImage: "key.fill")
                    }
              
                UserDetailsView().padding([.top, .leading]).tabItem {
                    Label("User detailes", systemImage: "person")
                }
              
                PlaceListView().tabItem {
                    Label("List Saleplaces", systemImage: "house")
                }
            
                SalePlaceView().tabItem{
                    Label("Add SalePlaces", systemImage: "plus")
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension ContentView {
  
    func Login() {
    
        network.logion(username: self.username, password: self.password){
            (resultat) in
            switch resultat {
            case .failure(let error):
                print(error)
                self.userIsNotLoggedIn = true
            case .success(let data):
                if data?.firstname?.compare("NOT EXCIST") == .orderedSame  {
                    userIsNotLoggedIn = true
                }
                else if data?.username != nil {
                    loginSuccess = true
                    LocalStorageService().saveUserId(user: data!)
                    LocalStorageService().setEmail(email: data?.email ?? "")
                    LocalStorageService().setUserame(username: data?.username ?? "")
                }
                else {
                    userIsNotLoggedIn = true
                }
            }

        }
    }
    
    func logOut() {
        loginSuccess = false
    }
    
    func cancel() {
        
    }
}

