//
//  Home.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 23/02/24.
//

import SwiftUI

struct Home: View {
    @State private var index = "Playstation"
    @State private var menu = false
    @State private var withMenu = UIScreen.main.bounds.width
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    
    func getColumns() -> Int{
        return (device == .pad || (device == .phone && width == .regular)) ? 3 : 1
        //return (device == .pad) ? 3 : ((device == .phone && width == .regular) ? 3 : 1)
    }
    
    var body: some View {
        ZStack{
            VStack{
                NavBar(index: $index, menu: $menu)
                ZStack{
                    if index == "Playstation"{
                        ScrollView(.vertical, showsIndicators:false){
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: getColumns()), spacing: 20){
                                ForEach(1...9, id:\.self){ _ in
                                    CardView()
                                        .padding(.all)
                                }
                            }
                        }
                    }else if index == "Xbox"{
                        VStack{
                            Color.green
                        }
                    }else{
                        VStack{
                            Color.red
                        }
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
                        }
                        Spacer()
                    }
                    .frame(width: withMenu - 200)
                    .background(Color.purple)
                    
                }
            }
        }.background(Color.white.opacity(0.9))
    }
}
