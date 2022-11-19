//
//  LoginView.swift
//  findfoodtruck
//
//  Created by Thomas Kleist on 07/09/2022.
//

import SwiftUI

struct LoginView: View {
    @State var email:String = ""
    @State var password:String = ""
    @State var loginSuccess: Bool = false
    @EnvironmentObject var loginObject: LoginObservable
    var body: some View {
        VStack{
            Button(action: Login) {
                Text("Login")
            }
            
            
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
extension LoginView {
    func Login() {
        loginObject.isLogin = false
    }
    
    func cancel() {
        
    }
}
