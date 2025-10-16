//
//  GIFView.swift
//  PortfolioApp
//
//  Created by Jaloliddin Zokirov on 15/10/25.
//

import SwiftUI
import WebKit

struct GIFView: UIViewRepresentable {
    let gifName: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .clear
        webView.isOpaque = false

        if let path = Bundle.main.path(forResource: gifName, ofType: "gif"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            webView.load(
                data,
                mimeType: "image/gif",
                characterEncodingName: "utf-8",
                baseURL: URL(fileURLWithPath: "")
            )
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
