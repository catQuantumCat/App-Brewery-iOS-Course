//
//  InfoView.swift
//  MiCard
//
//  Created by Huy on 16/10/24.
//

import SwiftUI

struct InfoView: View {

    let icon: Image
    let iconColor: Color
    let text: String

    init(icon: Image, iconColor: Color = Color.primary, text: String) {
        self.icon = icon
        self.text = text
        self.iconColor = iconColor
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 25 ).fill(Color("InfoColor")).frame(height: 50).overlay {
            
            HStack{
                icon.foregroundStyle(iconColor)
                Text(text).fontWeight(.bold)
            }
        }.safeAreaPadding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    InfoView(icon: Image.init(systemName: "person.crop.circle.fill"), text: "Sample")
}
