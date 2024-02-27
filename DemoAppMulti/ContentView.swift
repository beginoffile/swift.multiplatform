//
//  ContentView.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 23/02/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginShow : FirebaseViewModel
    var body: some View {
//        Home()
//            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//            .preferredColorScheme(.dark)
        return Group{
            if loginShow.show{
                Home()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//                    .preferredColorScheme(.dark)

            }else{
                Login()
            }
        }.onAppear{
            if (UserDefaults.standard.object(forKey: "sesion")) != nil{
                loginShow.show = true
            }
        }
    }
}

#Preview {
    ContentView()
}
