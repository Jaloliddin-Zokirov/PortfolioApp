//
//  HomeView.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.openURL) var openURL  // ✅ URL ochish muhiti

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Frontend Developer")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(LinearGradient(colors: [.indigo, .purple],
                                                    startPoint: .leading,
                                                    endPoint: .trailing))

                Text("Creating Innovative, Functional, and User-Friendly Websites for Digital Solutions.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                GIFView(gifName: "Coding")
                    .frame(height: 320)
                    .cornerRadius(20)
                    .shadow(radius: 10)

                Button(action: {
                    if let url = URL(string: "https://docs.google.com/document/d/1_x54gzAi6swKJDJSNGENcz2Z-MjnIj_R5xT7IsQerBo/export?format=pdf") {
                        openURL(url)
                    }
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "doc.text.fill")
                        Text("Download CV")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(colors: [.indigo, .purple],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .cornerRadius(12)
                    .padding(.horizontal, 40)
                    .shadow(color: .purple.opacity(0.3), radius: 10, x: 0, y: 5)
                    .scaleEffect(1.0)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            // mini bounce animation
                        }
                    }
                }
            }
            .padding(.top, 80)
        }
        .background(Color.black.ignoresSafeArea())
    }
}
