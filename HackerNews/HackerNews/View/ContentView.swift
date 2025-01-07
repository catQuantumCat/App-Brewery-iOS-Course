//
//  ContentView.swift
//  HackerNews
//
//  Created by Huy on 18/10/24.
//

import SwiftUI

struct ContentView: View {
    
     @StateObject var viewModel: ViewModel = ViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.newsList) { news in
                NavigationLink(value: news) {
                    Text(String(news.points)).font(.caption)
                    Text(news.title)
                }
            }
            .navigationTitle(Constants.appTitle)
            .navigationDestination(for: News.self) { news in
                NewsDetailView(news: news)
            }
            .onAppear(){
                viewModel.fetchNews()
            }
        }
    }
}

#Preview {
    ContentView()
}
