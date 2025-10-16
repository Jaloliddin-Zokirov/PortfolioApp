//
//  PortfolioAppApp.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

//import SwiftUI
//
//@main
//struct PortfolioAppApp: App {
//    var body: some Scene {
//        WindowGroup { ContentView() }
//    }
//}

import SwiftUI

@main
struct PortfolioAppApp: App {
    @State private var showWelcome = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showWelcome {
                    WelcomeView {
                        withAnimation(.easeInOut(duration: 1.2)) {
                            showWelcome = false
                        }
                    }
                } else {
                    ContentView()
                }
            }
        }
    }
}
