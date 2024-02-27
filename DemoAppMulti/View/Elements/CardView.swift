//
//  CardView.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 23/02/24.
//

import SwiftUI

struct CardView: View {
    var titulo: String
    var portada: String
    
    var body: some View {
        VStack(spacing:20){
        
            ImageFirebase(imageUrl: portada)
            Text(titulo)
                .font(.title)
                .bold()
                .foregroundColor(.black)
        }.padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

