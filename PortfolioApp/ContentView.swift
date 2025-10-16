//
//  ContentView.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }

            CertificatesView()
                .tabItem { Label("Certs", systemImage: "doc.text.image") }

            SkillsView()
                .tabItem { Label("Skills", systemImage: "bolt.fill") }

            PortfoliosView()
                .tabItem { Label("Projects", systemImage: "folder.fill") }
        }
        .tint(.blue)
    }
}

#Preview { ContentView() }
