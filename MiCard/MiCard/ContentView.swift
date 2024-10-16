//
//  ContentView.swift
//  MiCard
//
//  Created by Huy on 16/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack{
            
            Color(red: 0.09, green: 0.63, blue: 0.52).ignoresSafeArea()
            VStack {
                Image("duck")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .clipShape(.circle)
                    .overlay {
                        Circle().stroke(Color.white, lineWidth: 5)
                    }
                Text("Hello, world!")
                    .foregroundStyle(Color.white)
                    .font(.title)
                    .fontWeight(.bold)
                Text("This is a SwiftUI preview of MiCard.")
                    .foregroundStyle(Color.white)
                    .font(.body)
                InfoView(icon: Image(systemName: "phone.fill"),
                         iconColor: Color.green,
                         text: "123456789"
                )
                InfoView(icon: Image(systemName: "phone.fill"),
                         iconColor: Color.green,
                         text: "123456789"
                )
            }

        }

    }
}

#Preview {
    ContentView()
}


