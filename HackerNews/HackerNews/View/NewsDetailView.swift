//
//  NewsDetailView.swift
//  HackerNews
//
//  Created by Huy on 18/10/24.
//

import SwiftUI
import WebKit

struct NewsDetailView: View {
    
    let news: News
    
    init(news: News) {
        self.news = news
    }
    
    var body: some View {
        WebView(url: news.url)
            .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(news.title)
        
        
    }
}



//#Preview {
//    NewsDetailView()
//}
