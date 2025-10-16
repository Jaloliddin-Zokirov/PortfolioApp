//
//  WelcomeView.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

import SwiftUI

struct WelcomeView: View {
    var onFinish: () -> Void
    @State private var text = ""
    @State private var show = true
    let fullText = "Welcome to My Portfolio"

    var body: some View {
        ZStack {
            // Fon effekti
            LinearGradient(colors: [.indigo.opacity(0.3), .purple.opacity(0.3)],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .blur(radius: 50)
                .opacity(0.8)

            VStack(spacing: 40) {
                // Iconlar
                HStack(spacing: 25) {
                    IconCircle(system: "curlybraces")
                    IconCircle(system: "person.circle.fill")
                    IconCircle(system: "network")
                }
                .opacity(show ? 1 : 0)
                .scaleEffect(show ? 1 : 0.7)
                .animation(.easeInOut(duration: 1), value: show)

                // Matn
                VStack(spacing: 10) {
                    Text(text)
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundStyle(LinearGradient(colors: [.indigo, .purple],
                                                        startPoint: .leading,
                                                        endPoint: .trailing))
                        .shadow(color: .purple.opacity(0.2), radius: 10, x: 0, y: 5)
                        .onAppear {
                            typeWriter()
                        }

                    Text("jaloliddindev.uz")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .opacity(0.8)
                }

                // Pastda yuklanish animatsiyasi
                ProgressView()
                    .tint(.purple)
                    .scaleEffect(1.4)
                    .padding(.top, 30)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation(.easeInOut(duration: 0.8)) {
                    show = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    onFinish()
                }
            }
        }
    }

    func typeWriter() {
        var currentIndex = 0
        Timer.scheduledTimer(withTimeInterval: 0.12, repeats: true) { timer in
            if currentIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: currentIndex)
                text.append(fullText[index])
                currentIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

struct IconCircle: View {
    let system: String
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(colors: [.indigo, .purple],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .frame(width: 60, height: 60)
                .blur(radius: 0.5)
                .opacity(0.8)
            Image(systemName: system)
                .foregroundColor(.white)
                .font(.system(size: 24))
        }
        .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 4)
    }
}
