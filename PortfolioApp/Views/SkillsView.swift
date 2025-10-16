//
//  SkillsView.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

import SwiftUI

struct SkillsView: View {
    @StateObject private var vm = SkillsVM()

    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading { ProgressView("Loading...") }
                else if let err = vm.error {
                    VStack { Text("Xato: \(err)").foregroundColor(.red)
                        Button("Retry") { Task { await vm.load() } }
                    }
                } else {
                    List(vm.items) { s in
                        HStack(spacing: 12) {
                            RemoteImage(urlString: s.image, width: 44, height: 44, corner: 8)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(s.title ?? "—").font(.headline)
                                Text(s.description ?? "").font(.subheadline).foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Skills")
        }
        .task { await vm.load() }
    }
}
