//
//  NavBar.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 23/02/24.
//

import SwiftUI

struct NavBar: View {
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var index: String
    @Binding var menu: Bool
    
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
        .padding()
        .background(Color.purple)
    }
}

