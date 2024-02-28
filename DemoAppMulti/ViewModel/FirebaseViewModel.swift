//
//  FirebaseViewModel.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 24/02/24.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseViewModel: ObservableObject{
    @Published var show = false
    @Published var datos = [FirebaseModel]()
    
    
    func login(email: String, pass:String, completion: @escaping (_ done:Bool) -> Void ){
        Auth.auth()
            .signIn(withEmail: email, password: pass){ (user, error) in
                if user != nil{
                    print("Entro")
                    completion(true)
                }else{
                    if let error = error?.localizedDescription{
                        print("Error en el firebase", error)
                        completion(false)
                    }else{
                        print("Error en la app")
                        completion(false)
                    }
                    
                }
                    
            }
    }
    func createuser(email: String, pass:String, completion: @escaping (_ done:Bool) -> Void ){
        Auth.auth().createUser(withEmail: email, password: pass, completion: {(user, error) in
            if user != nil{
                print("Entro y se registro")
                completion(true)
            }else{
                if let error = error?.localizedDescription{
                    print("Error en el firebase de registro", error)
                    completion(false)
                }else{
                    print("Error en la app")
                    completion(false)
                }
                
            }
        })
    }
    
//    Base de datos
//    Guardar
    func save(titulo: String, desc: String, plataforma: String, portada: Data, completion: @escaping (_ done: Bool)->Void){

        let storage = Storage.storage().reference()
        
        let nombrePortada = UUID()
        let directorio = storage.child("imagenes/\(nombrePortada)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        directorio.putData(portada, metadata:metadata){data, error in
            if error == nil{
                print("guardo la imagen")
                //GUARDAR TEXTO
                let db = Firestore.firestore()
                let id = UUID().uuidString
                guard let idUser = Auth.auth().currentUser?.uid else {return}
                guard let email = Auth.auth().currentUser?.email else {return}
                let campos: [String: Any] = ["titulo": titulo, "descripcion":desc, "portada": String(describing: directorio), "idUser": idUser, "email": email]
                db.collection(plataforma).document(id).setData(campos){error in
                    if let error = error?.localizedDescription{
                        print("error al guardar en firestone", error)
                        completion(false)
                    }else{
                        print("guardo todo")
                        completion(true)
                    }
                }
                
                //FIN GURDAR TEXTO
                
            }else{
                if let error = error?.localizedDescription{
                    print("Fallo al subir la imagen en storage", error)
                }else{
                    print("fallo la app")
                }
            }
        }
        
        

    }
    
    func getData(plataforma:String){
        let db = Firestore.firestore()
        db.collection(plataforma).addSnapshotListener { (QuerySnapshot, error) in
            if let error = error?.localizedDescription{
                print("Error al mostrar datos", error)
            }else{
                self.datos.removeAll()
                for document in QuerySnapshot!.documents{
                    let valor = document.data()
                    let id = document.documentID
                    let titulo = valor["titulo"] as? String ?? "Sin titulo"
                    let desc = valor["desc"] as? String ?? "sin desc"
                    let portada = valor["portada"] as? String ?? "Sin portada"
                    DispatchQueue.main.async{
                        let registros = FirebaseModel(id: id, titulo: titulo, desc: desc, portada: portada)
                        self.datos.append(registros)
                    }
                }
            }
            
        }
        
        
    }
    
//    Eliminar
    func delete(fireModel: FirebaseModel, plataforma:String){
//        eliminar del firestore

        let id = fireModel.id
        let db = Firestore.firestore()
        db.collection(plataforma).document(id).delete()
//        Eliminar del storage
        let imagen = fireModel.portada
        let borrarImagen = Storage.storage().reference(forURL: imagen)
        borrarImagen.delete(completion: nil)
    }
    
//    EDITAR
    func edit(titulo: String, desc: String, plataforma: String, id:String, completion: @escaping (_ done:Bool) -> Void){
        let db = Firestore.firestore()

        let campos: [String:Any] = ["titulo":titulo, "desc": desc]
        db.collection(plataforma).document(id).updateData(campos){error in
            if let error = error?.localizedDescription{
                print("Error al editar", error)
            }else{
                print("edito solo texto")
            completion(true)
            }
        }
    }
}


