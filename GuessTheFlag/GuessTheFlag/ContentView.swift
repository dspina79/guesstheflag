//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dave Spina on 11/20/20.
//

import SwiftUI

struct ContentView: View {
    @State private var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    @State private var score: Int = 0
    
    @State private var showScore = false
    @State private var tappedAnswer = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the country of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) {
                    number in
                    Button(action: {
                        flaggTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 3)
                    }
                }
                Text("Current Score: \(self.score)")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title3)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showScore) {
            Alert(title: Text(tappedAnswer), message: Text("Your score is \(self.score)"), dismissButton: .default(Text("Ok")) {
                    resetGame()
                })
        }
    }
    
    func flaggTapped(_ number: Int) {
        if number == self.correctAnswer {
            self.tappedAnswer = "Correct"
            self.score += 1
        } else {
            self.tappedAnswer = "Incorrect, that flag is \(self.countries[number])."
            if self.score > 0 {
                self.score += -1
            }
        }
        self.showScore = true
    }
    
    func resetGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
