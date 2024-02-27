//
//  NavBar.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 23/02/24.
//

import SwiftUI
import Firebase

struct NavBar: View {
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var index: String
    @Binding var menu: Bool
    @EnvironmentObject var loginShow: FirebaseViewModel
    
    var body: some View {
        HStack{
            Text("My Game")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .foregroundColor(.white)
                .font(.system(size: device == .phone ? 25 : 35))
            Spacer()
            if device == .pad{
//                menu ipad
                HStack(spacing: 25){
                    ButtonView(index: $index, menu: $menu, title: "Playstation")
                    ButtonView(index: $index, menu: $menu, title: "Xbox")
                    ButtonView(index: $index, menu: $menu, title: "Nintendo")
                    ButtonView(index: $index, menu: $menu, title: "Agregar")
                    
                    Button(action:{
                        try! Auth.auth().signOut()
                        UserDefaults.standard.removeObject(forKey: "sesion")
                        loginShow.show = false
                    }){
                        Text("Salir")
                            .font(.title)
                            .frame(width: 150)
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                        
                    }.background(
                        Capsule().stroke(Color.white)
                    )
                }
                
            }else{
//                menu iphone
                Button(action:{
                    withAnimation{
                        menu.toggle()
                    }
                }){
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }
            }
            
        }
        .padding(.top, 30)
        .padding()
        .background(Color.purple)
    }
}

