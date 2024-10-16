//
//  ContentView.swift
//  Dicee SwiftUI
//
//  Created by Huy on 16/10/24.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var leftDiceNum : Int  = 1
    @State var rightDiceNum : Int  = 1
    var body: some View {
        ZStack {
            Image("background")
                .resizable().ignoresSafeArea()
            VStack {
                Image("diceeLogo")
                Spacer()

                HStack {
                    DiceView(leftDiceNum)
                    DiceView(rightDiceNum)
                }
                Spacer()

                RollButton(title: "Roll") {
                    self.leftDiceNum = Int.random(in: 1...6)
                    self.rightDiceNum = Int.random(in: 1...6)
                }

            }
        }
    }
}

struct DiceView: View {
    let diceNum: Int

    init(_ diceNum: Int) {
        self.diceNum = diceNum
    }

    var body: some View {
        Image("dice\(diceNum)")
    }
}

struct RollButton: View {
    let title: String
    let completion: () -> Void
    init(title: String, completion:
        @escaping () -> Void)
    {
        self.title = title
        self.completion = completion
    }

    var body: some View {
        Button(title) {
            
            
            completion()
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.red)
        .foregroundStyle(.white)
        .font(.system(size: 50))
        .safeAreaPadding()
        
    }
}

#Preview {
    ContentView()
}
