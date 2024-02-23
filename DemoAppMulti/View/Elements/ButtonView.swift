//
//  ButtonView.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 23/02/24.
//

import SwiftUI

struct ButtonView: View {
    @Binding var index:String
    @Binding var menu: Bool
    var title: String
    
    var body: some View {
        Button(action:{
            withAnimation{
                index = title
            }
            
        }){
            Text(title)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(index==title ? .bold: .none )
                .foregroundColor(index == title ? .white: Color.white.opacity(0.6))
        }
    }
}

