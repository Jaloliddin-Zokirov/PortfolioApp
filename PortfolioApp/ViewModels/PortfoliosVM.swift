//
//  PortfoliosVM.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

import Foundation
import Combine

@MainActor
final class PortfoliosVM: ObservableObject {
    @Published var items: [PortfolioItem] = []
    @Published var isLoading = false
    @Published var error: String?

    func load() async {
        guard !isLoading else { return }
        isLoading = true; defer { isLoading = false }

        do {
            items = try await APIClient.shared.get(Endpoints.portfolios)
            error = nil
        } catch {
            self.error = error.localizedDescription
        }
    }
}
