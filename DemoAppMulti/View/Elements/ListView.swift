//
//  ListView.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 26/02/24.
//

import SwiftUI

struct ListView: View {
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    func getColumns() -> Int{
        return (device == .pad || (device == .phone && width == .regular)) ? 3 : 1
        //return (device == .pad) ? 3 : ((device == .phone && width == .regular) ? 3 : 1)
    }
    
    var plataforma: String
    @StateObject var datos = FirebaseViewModel()
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators:false){
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: getColumns()), spacing: 20){
                ForEach(datos.datos){ item in
                    CardView(titulo: item.titulo, portada: item.portada, fireModel: item, plataforma: plataforma)
                        .padding(.all)
                }
            }
            
        }.onAppear{
            datos.getData(plataforma: plataforma)
        }
    }
}
