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
    var body: some View {
        
        
            Form {
                TextField("Firstname", text: $firstname).padding(1)
                TextField("Lastname", text: $lastname).padding(1)
                TextField("Username", text: $username).padding()
                TextField("E-mail", text: $email).padding()
                SecureField("Password", text: $password).padding().cornerRadius(/*@START_MENU_TOKEN@*/4.0/*@END_MENU_TOKEN@*/)
                SecureField("Repeat Password", text: $repeatPassword).padding().alert("Password matcher ikke", isPresented: $passwordNotSame) {}
                
                HStack {
                    Button(action: createUser) {
                        Text("Opret Bruger")
                    }.padding()
                        .background(Color(red: 0, green: 0, blue: 0.5))
                        .clipShape(Capsule()).alert("Bruger Oprettet", isPresented: $isCreated) {
                            
                            Text("Bruger oprettet")
                        }.alert("Fejl  ", isPresented: $isfaliure) {
                            Text("Fejl I oprettelse")
                        }
                    
                    
                    Button(action: cancel) {
                        Text("Cancel")
                    }.padding()
                        .background(Color(red: 0.9, green: 0, blue: 0))
    
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
    }
    
    func cancel() {}
       
 
}
