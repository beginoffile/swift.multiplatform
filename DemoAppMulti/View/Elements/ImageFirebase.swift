//
//  ImageFirebase.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 26/02/24.
//

import SwiftUI

struct ImageFirebase: View {
    let imagenAlternativa = UIImage(systemName: "photo")
    @ObservedObject var imageLoader: PortadaViewModel
    
    init(imageUrl: String){
        imageLoader = PortadaViewModel(imageUrl: imageUrl)
        
    }
    var image: UIImage?{
        imageLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        Image(uiImage: (image ?? imagenAlternativa)!)
            .resizable()
            .cornerRadius(20)
            .shadow(radius: 5)
            .aspectRatio(contentMode: .fit)
    }
}


