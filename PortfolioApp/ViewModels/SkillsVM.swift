//
//  SkillsVM.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

import Foundation
import Combine

@MainActor
final class SkillsVM: ObservableObject {
    @Published var items: [Skill] = []
    @Published var isLoading = false
    @Published var error: String?

    func load() async {
        guard !isLoading else { return }
        isLoading = true; defer { isLoading = false }
        do {
            let data: [Skill] = try await APIClient.shared.get(Endpoints.skills)
            items = data
        } catch { self.error = error.localizedDescription }
    }
}
