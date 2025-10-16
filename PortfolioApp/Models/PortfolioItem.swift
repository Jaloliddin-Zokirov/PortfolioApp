//
//  Project.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

import Foundation

struct PortfolioItem: Identifiable, Codable {
    let id: Int
    let title: String?
    let description: String?
    let features: [String]?
    let tech_stack: [String]?
    let image: String?
    let github_link: String?
    let in_link: String?
    let tg_link: String?
    let linkedin_link: String?
    let link: String?
}
