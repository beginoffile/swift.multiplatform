//
//  DemoAppMultiApp.swift
//  DemoAppMulti
//
//  Created by Aguid Ramirez Sanchez on 23/02/24.
//

import SwiftUI


@main
struct DemoAppMultiApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        let login = FirebaseViewModel()
        WindowGroup {
            ContentView().environmentObject(login)
        }
    }
}
