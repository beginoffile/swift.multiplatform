//
//  EditarView.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 27/02/24.
//

import SwiftUI

struct EditarView: View {
    @State private var titulo = ""
    @State private var desc =  ""
   
    var plataforma: String
    var datos: FirebaseModel
    
    @StateObject private var guardar = FirebaseViewModel()
    
    @State private var imageData : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    @State private var progress = false
    @Environment(\.presentationMode) var presentationMode
    
    
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
                        .onAppear{
                            titulo = datos.titulo
                        }
                    TextEditor(text: $desc)
                        .frame(height: 200)
                        .onAppear{
                            desc = datos.desc
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
                        
                       
                        
                    }
                    
                    Button(action: {
                        progress = true
                        if imageData.isEmpty{
                            guardar.edit(titulo: titulo, desc: desc, plataforma: plataforma, id: datos.id) { done in
                                if done{
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }else{
                            progress = true
                            guardar.editWithImage(titulo: titulo, desc: desc, plataforma: plataforma, id: datos.id, fireModel: datos, portada: imageData) { done in
                                if done{
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                        
                    }, label: {
                        Text("Guardar")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                    })
                    
                    if progress{
                        Text("Espere un momento por favor").foregroundColor(.black)
                        ProgressView()
                    }

                    Spacer()
                }.padding(.all)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
            .onAppear{
                print(datos)
            }
    }
}

#Preview {
    AddView()
}
