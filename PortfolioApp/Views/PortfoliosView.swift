//
//  Projects.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

import SwiftUI

struct PortfoliosView: View {
    @StateObject private var vm = PortfoliosVM()

    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading { ProgressView("Loading...") }
                else if let err = vm.error {
                    VStack { Text("Xato: \(err)").foregroundColor(.red)
                        Button("Retry") { Task { await vm.load() } }
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(vm.items) { p in
                                VStack(alignment: .leading, spacing: 10) {
                                    RemoteImage(urlString: p.image, width: UIScreen.main.bounds.width * 0.9, height: 180, corner: 12)
                                    Text(p.title ?? "—").font(.headline)
                                    Text(p.description ?? "").font(.subheadline).foregroundColor(.secondary)

                                    if let feats = p.features, !feats.isEmpty {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            VStack(spacing: 8) {
                                                ForEach(feats, id: \.self) { FeatureTag(text: $0) }
                                            }
                                        }
                                    }
                                    
                                    if let stack = p.tech_stack, !stack.isEmpty {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            VStack(spacing: 8) {
                                                ForEach(stack, id: \.self) { FeatureTag(text: $0) }
                                            }
                                        }
                                    }

                                    HStack(spacing: 12) {
                                        if let u = p.link, let url = URL(string: u) {
                                            Link("Open", destination: url)
                                        }
                                        if let g = p.github_link, let url = URL(string: g) {
                                            Link("GitHub", destination: url)
                                        }
                                        if let t = p.tg_link, let url = URL(string: t) {
                                            Link("Telegram", destination: url)
                                        }
                                        if let l = p.linkedin_link, let url = URL(string: l) {
                                            Link("LinkedIn", destination: url)
                                        }
                                    }.font(.footnote)
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(14)
                                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Projects")
        }
        .task { await vm.load() }
    }
}
