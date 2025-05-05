//
//  ContentView.swift
//  beluga combat
//
//  Created by Vsevolod Beluga on 05.05.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isPressed = false
    @State private var counter = UserDefaults.standard.integer(
        forKey: "clickCount"
    )
    @State private var rank = UserDefaults.standard.string(
        forKey: "fishRank"
    ) ?? "poor_fish"
    
    private let backgroundColor = Color(red: 0.5, green: 0.5, blue: 0.55)
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack {
                Text("Кошелек : \(counter) 🪙")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                
                Spacer()
                
                fishButton
                
                Spacer()
                
                HStack {
                    Button("0"){
                        counter = 0
                        UserDefaults.standard.set(counter, forKey: "clickCount")
                        checkRank()
                    }.padding(5)
                        .background(.red)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                    
                    Button("+100"){
                        counter = 100
                        UserDefaults.standard.set(counter, forKey: "clickCount")
                        checkRank()
                    }.padding(5)
                        .background(.green)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
    
    private var fishButton: some View {
        Image(rank)
            .resizable()
            .aspectRatio(1.5, contentMode: .fit)
            .scaleEffect(isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isPressed)
            .onTapGesture (perform: imageTap)
    }
    private func imageTap() {
        isPressed = true
        counter += 1
        UserDefaults.standard.set(counter, forKey: "clickCount")
        
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isPressed = false
        }
        
        checkRank()
    }
    
    private func checkRank() {
        if counter >= 100 {
            rank = "business_fish"
            UserDefaults.standard.set(rank, forKey: "fishRank")
        } else {
            rank = "poor_fish"
            UserDefaults.standard.set(rank, forKey: "fishRank")
        }
    }
}

#Preview {
    ContentView()
}
