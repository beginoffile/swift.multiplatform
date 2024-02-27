//
//  Login.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 24/02/24.
//

import SwiftUI

struct Login: View {
    @State private var email = ""
    @State private var pass = ""
    @StateObject var login = FirebaseViewModel()
    var device = UIDevice.current.userInterfaceIdiom
    
    @EnvironmentObject var loginShow: FirebaseViewModel
    
    
    
    var body: some View {
        ZStack{
            Color.purple.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Text("My Games")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .frame(width: device == .pad ? 400: nil)
                SecureField("Pass", text: $pass)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: device == .pad ? 400: nil)
                    .padding(.bottom,20)
                Button(action:{
                    login.login(email: email, pass: pass, completion:{ (done: Bool) in
                        if done{
                            UserDefaults.standard.set(true, forKey: "sesion")
                            loginShow.show.toggle()
                        }
                    })
                }){
                    Text("Entrar")
                        .font(.title)
                        .frame(width: 200)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                }.background(
                Capsule()
                    .stroke(Color.white)
                )
                Divider()
                Button(action:{
                    login.createuser(email: email, pass: pass, completion:{ (done: Bool) in
                        if done{
                            UserDefaults.standard.set(true, forKey: "sesion")
                            loginShow.show.toggle()
                        }
                    })
                }){
                    Text("Registrarse")
                        .font(.title)
                        .frame(width: 200)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                }.background(
                Capsule()
                    .stroke(Color.white)
                )
            }.padding(.all)
        }
    }
}

#Preview {
    Login()
}
