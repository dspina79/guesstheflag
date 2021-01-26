//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dave Spina on 11/20/20.
//

import SwiftUI

struct FlatFlagImage: View {
    var imageName: String
    var shadowBorder: CGFloat
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Rectangle())
            .overlay(Rectangle().stroke(Color.white, lineWidth: self.shadowBorder))
            .shadow(color: .black, radius: 5)
    }
}

struct FlagImage: View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white, lineWidth: 2))
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5)
    }
}

struct ContentView: View {
    let labels = [
        "Estonia" : "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three equal vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe gold. Bottom stripe red.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Monaco" : "Monaco flag",
        "Nigeria": "Nigerian flag",
        "Poland": "Polish Flag",
        "Span": "Flag with two red stripes, one on the stop and one on the bottom. A middle yellow band has a coat of arms on the left side.",
        "UK": "Flag depicting the nion Jack",
        "US": "Flag with stars and stripes"
    ]
    @State private var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    @State private var tappedAnswerDescription = ""
    @State private var score: Int = 0
    
    @State private var showScore = false
    @State private var tappedAnswer = ""
    @State private var winningStreak = 0
    
    @State private var selectedNum = -1
    
    @State private var explicitAnimationAmount = 0.0
    @State private var otherOpacity = 1.0
    
    @State private var backColors = [Color.blue, Color.green];
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: backColors), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack() {
                Text("Tap the flag that matches")
                    .foregroundColor(.white)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                Text("\(countries[correctAnswer])")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                VStack(spacing: 30) {
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            withAnimation  {
                                checkAnswer(number)
                                if (number == selectedNum) {
                                    self.explicitAnimationAmount += 360.0
                                }
                                self.otherOpacity = 0.25
                            }
                        }) {
                            FlatFlagImage(imageName: self.countries[number], shadowBorder: 2)
                        }
                        .accessibility(label: Text(labels[self.countries[number], default:
                                                          "Unknown flag"] ))
                        .rotation3DEffect(
                            .degrees(number == correctAnswer ? explicitAnimationAmount : 0),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        .opacity(number == correctAnswer ? 1 : otherOpacity)
                      
                    }
                }
                Text("Score: \(self.score)")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
            }.alert(isPresented: $showScore) {
                Alert(title: Text(tappedAnswer), message: Text(tappedAnswerDescription), dismissButton: .default(Text("Continue")){
                        nextGame()
                })
            }
        }
    }
    
    func checkAnswer(_ number: Int) {
        self.selectedNum = number
        if number == correctAnswer {
            self.tappedAnswer = "That's correct."
            switch winningStreak {
            case 0..<2:
                self.tappedAnswerDescription = "Good answer."
            case 2..<5:
                self.tappedAnswerDescription = "You're on a roll."
            default:
                self.tappedAnswerDescription = "You're on FIRE!!!"
            }
            self.score += 1
            self.winningStreak += 1
            
        } else {
            self.backColors = [Color.red, Color.orange]
            self.tappedAnswer = "That's incorrect"
            self.tappedAnswerDescription = "You clicked \(countries[number])"
            if self.score > 0 {
                self.score += -1
            }
            self.winningStreak = 0
        }
        self.showScore = true
    }
    
    func nextGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
        otherOpacity = 1.0
        selectedNum = -1
        backColors = [Color.blue, Color.green];
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
