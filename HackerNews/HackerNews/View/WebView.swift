//
//  WebView.swift
//  HackerNews
//
//  Created by Huy on 3/1/25.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    let url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url{
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
