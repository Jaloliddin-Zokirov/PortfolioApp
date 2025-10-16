//
//  SertificatesView.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

import SwiftUI

struct CertificatesView: View {
    @StateObject private var vm = CertificatesVM()

    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading {
                    ProgressView("Loading...")
                } else if let err = vm.error {
                    VStack(spacing: 8) {
                        Text("Xato: \(err)").foregroundColor(.red)
                        Button("Qayta urinish") { Task { await vm.load() } }
                    }
                } else {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 12)], spacing: 12) {
                        ForEach(vm.items) { c in
                            RemoteImage(urlString: c.img, width: nil, height: 120, corner: 10)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Certificates")
        }
        .task { await vm.load() }
    }
}
