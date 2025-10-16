//
//  CertificatesVM.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

import Foundation
import Combine

@MainActor
final class CertificatesVM: ObservableObject {
    @Published var items: [Certificate] = []
    @Published var isLoading = false
    @Published var error: String?

    func load() async {
        guard !isLoading else { return }
        isLoading = true; defer { isLoading = false }
        do {
            let data: [Certificate] = try await APIClient.shared.get(Endpoints.certificates)
            items = data
        } catch {
            self.error = error.localizedDescription
        }
    }
}
