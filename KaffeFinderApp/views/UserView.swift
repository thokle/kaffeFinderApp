//
//  UserView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 04/09/2022.
//

import SwiftUI


struct UserView: View {
    
    @State var networtkServce: NetWorkService = NetWorkService()
    @State var user: User = User()
    @State var firstname: String = ""
    @State var lastname: String = ""
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    @State var phone: Int = 0
    @State var comparePassword:Bool = true
    @State var isCreated:Bool =  false
    @State var isfaliure:Bool = false
    @State var passwordNotSame:Bool = false

    @State var emailExist:Bool = false
    var body: some View {
        
        
            Form {
                TextField("Firstname", text: $firstname).padding(1)
                TextField("Lastname", text: $lastname).padding(1)
                TextField("Username", text: $username).padding(1)
                TextField("E-mail", text: $email).padding(1).onTapGesture {
                    doesEmailExcist()
                }.alert("E-mail exist", isPresented: $emailExist) {
                    Text("E-mail address does already exist")
                }
                SecureField("Password", text: $password).padding(1)
                SecureField("Repeat Password", text: $repeatPassword).padding(1).alert("Password matcher ikke", isPresented: $passwordNotSame) {}
                
                HStack {
                    Button(action: createUser) {
                        Text("Opret Bruger")
                    }
                    .background(Color(red: 0, green: 0, blue: 0.5)).buttonStyle(.bordered)
                        .alert("Bruger Oprettet", isPresented: $isCreated) {
                            
                            Text("Bruger oprettet")
                        }.alert("Fejl  ", isPresented: $isfaliure) {
                            Text("Fejl I oprettelse")
                        }
                    
                    
                    Button(action: cancel) {
                        Text("Cancel")
                    }
                        .background(Color(red: 0.9, green: 0, blue: 0)).foregroundColor(.white).buttonStyle(.bordered)
    
                }
            }.padding(1)
       
    }
    
   
}


struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
    
}



extension UserView {

    func  createUser() {
     
        if  !emailExist {
            var user = User()
            user.firstname = self.firstname
            user.lastname = self.lastname
            user.email = self.email.lowercased()
            user.password = self.password
            user.username = self.username
            
            if (self.password.compare(self.repeatPassword) == .orderedSame) {
                self.networtkServce.addUser(user: user) {
                    (c) in
                    
                    switch c {
                    case .failure(let error):
                        isfaliure = true
                    case .success(let success):
                        isCreated = true
                    }
                    
                    
                    
                }
            } else {
                self.passwordNotSame = true
            }
        } else {
            emailExist = true
        }
    }
    
    func cancel() {}
       
    func doesEmailExcist() {
            self.networtkServce.getUserByEmail(email: self.email){
         (res) in
            switch res {
            case .success(let success):
                if  success.email?.count ?? 0 > 0 {
                    emailExist = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            
            }
        }
    }
    
 
}
