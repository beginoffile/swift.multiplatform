//
//  Home.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 23/02/24.
//

import SwiftUI
import Firebase

struct Home: View {
    @State private var index = "Playstation"
    @State private var menu = false
    @State private var withMenu = UIScreen.main.bounds.width
    @EnvironmentObject var loginShow: FirebaseViewModel
    
    
   
    var body: some View {
        ZStack{
            VStack{
                NavBar(index: $index, menu: $menu)
                ZStack{
                    if index == "Playstation"{
                        ListView(plataforma: "playstation")
                    }
                    else if index == "Xbox"{
                            ListView(plataforma: "xbox")
                    }else if index == "Nintendo"{
                        ListView(plataforma: "nintendo")
                    }else{
                        AddView()
                    }

                }
                
            }
//            termina navbar ipad
            if menu{
                HStack{
                    Spacer()
                    VStack{
                        HStack{
                            Spacer()
                            Button(action:{
                                withAnimation{
                                    menu.toggle()
                                }
                                }){
                                    Image(systemName: "xmark")
                                        .font(.system(size: 22, weight: .bold))
                                }
                        }.padding()
                        .padding(.top, 50)
                        VStack(alignment: .trailing){
                            ButtonView(index: $index, menu: $menu, title: "Playstation")
                            ButtonView(index: $index, menu: $menu, title: "Xbox")
                            ButtonView(index: $index, menu: $menu, title: "Nintendo")
                            Button(action: {
                                try! Auth.auth().signOut()
                                UserDefaults.standard.removeObject(forKey: "sesion")
                                loginShow.show = false
                            }, label: {
                                Text("Salir")
                                    .foregroundColor(.white)
                                    .font(.system(size: 22, weight: .bold))
                            })
                        }
                        Spacer()
                    }
                    .frame(width: withMenu - 200)
                    .background(Color.purple)
                    
                }
            }
        }.background(Color("fondo"))
    }
}
