//
//  PortadaViewModel.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 26/02/24.
//

import Foundation
import FirebaseStorage

class PortadaViewModel: ObservableObject{
    @Published var data: Data? = nil
    
    init(imageUrl: String){
        let storageImage = Storage.storage().reference(forURL: imageUrl)
        storageImage.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error?.localizedDescription{
                print("error al traer la imagen",error)
            }else{
                DispatchQueue.main.async{
                    self.data = data
                    print("Ok")
                }
            }
        }
    }
}
