//
//  Config.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

import Foundation

enum AppEnv {
    // Lokal: iPhone’dan Railway/localhost’ga test qilmoqchi bo‘lsang:
    // Mac’ning IP manzilini yoz: masalan 192.168.1.23
    static let host = "https://api.jaloliddindev.uz" // yoki "https://api.yoursite.uz"
}

// Serveringda `/main/...` prefiks bor — shu yerni bitta joyda ushlab turamiz:
enum API {
    static let base = "\(AppEnv.host)/main"
}
