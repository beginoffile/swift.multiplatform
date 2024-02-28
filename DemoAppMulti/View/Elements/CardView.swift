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
    
    var fireModel: FirebaseModel
    var plataforma: String
    
    @StateObject var datos = FirebaseViewModel()
    
    var body: some View {
        VStack(spacing:20){
        
            ImageFirebase(imageUrl: portada)
            Text(titulo)
                .font(.title)
                .bold()
                .foregroundColor(.black)
            Button(action: {
                datos.delete(fireModel: fireModel, plataforma: plataforma)
            }, label: {
                Text("Eliminar")
                    .foregroundColor(.red)
                    .padding(.vertical, 10)
                    .padding(.horizontal,25)
                    .background(Capsule().stroke(Color.red))
            })
        }.padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

