//
//  AddView.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 24/02/24.
//

import SwiftUI

struct AddView: View {
    @State private var titulo = ""
    @State private var desc =  ""
    var consolas = ["playstation","xbox","nintendo"]
    @State private var plataforma = "playstation"
    @StateObject private var guardar = FirebaseViewModel()
    
    @State private var imageData : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.yellow.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack{
                    
                    NavigationLink(""){
                      EmptyView()
                    }.navigationBarHidden(true)
                    
                    .navigationDestination(isPresented: $imagePicker) {
                        ImagePicker(show: $imagePicker, image: $imageData, source: source)
                    }
                    
                 
                    
                    TextField("Titulo", text: $titulo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextEditor(text: $desc)
                        .frame(height: 200)
                    Picker("Consola", selection: $plataforma){
                        ForEach(consolas, id:\.self, content: {item in
                            Text(item).foregroundColor(.black)
                        })
                    }
                    
                    Button(action: {
                        mostrarMenu.toggle()
                    }, label: {
                        Text("Cargar Imagen")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                    }).actionSheet(isPresented: $mostrarMenu, content: {
                        ActionSheet(title: Text("Menu"), message: Text("Selecciona una opcion"), buttons: [
                            .default(Text("Camara"), action: {
                            source = .camera
                            imagePicker.toggle()
                            }),
                            .default(Text("Libreria"), action: {
                            source = .photoLibrary
                            imagePicker.toggle()
                            }),
                            .default(Text("Cancelar"))
                        ])
                    })
                    if imageData.count != 0{
                        Image(uiImage: UIImage(data:  imageData)!)
                            .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(15)
                        
                        Button(action: {
                            guardar.save(titulo: titulo, desc: desc, plataforma: plataforma, portada: imageData, completion: {done in
                                if done{
                                    titulo = ""
                                    desc=""
                                    imageData = .init(capacity: 0)
                                }
                            })
                            
                        }, label: {
                            Text("Guardar")
                                .foregroundColor(.black)
                                .bold()
                                .font(.largeTitle)
                        })
                        
                    }

                    Spacer()
                }.padding(.all)
            }
        }
    }
}

#Preview {
    AddView()
}
