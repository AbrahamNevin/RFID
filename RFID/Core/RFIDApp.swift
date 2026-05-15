//
//  RFIDApp.swift
//  RFID
//
//  Created by Nevin Abraham on 15/05/26.
//

import SwiftUI
import Combine

@main
struct RFIDApp: App {
    @StateObject private var appViewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appViewModel)
                .preferredColorScheme(.dark)
        }
    }
}
