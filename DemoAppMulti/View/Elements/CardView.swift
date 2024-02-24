//
//  CardView.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 23/02/24.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack(spacing:20){
            Image("imagedemo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Sonic")
                .font(.title)
                .bold()
                .foregroundColor(.black)
        }.padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

#Preview {
    CardView()
}
