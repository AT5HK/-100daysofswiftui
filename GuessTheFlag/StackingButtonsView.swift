//
//  StackingButtonsView.swift
//  GuessTheFlag
//
//  Created by auston salvana on 1/25/22.
//

import SwiftUI

struct StackingButtonsView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreValue = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria",
                     "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var flagSelected = 0
    @State private var guessed = 0
    @State private var showingReset = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                VStack() {
                    Spacer()
                    
                    Text("Guess the Flag")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    VStack(spacing: 15) {
                        VStack {
                            Text("tap the flag of")
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                            
                            Text(countries[correctAnswer])
                                .foregroundStyle(.secondary)
                                .font(.largeTitle.weight(.semibold))
                        }
                            
                        ForEach(0..<3) { number in
                            Button() {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Spacer()
                    Spacer()
                    
                    Text("Score title: \(scoreValue)")
                        .foregroundColor(.white)
                        .font(.largeTitle.bold())
                    Spacer()
                }
                .padding()
            }
            .alert(scoreTitle ,isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                if correctAnswer != flagSelected {
                    Text("wrong that is \(countries[flagSelected])")
                }
                Text("your score is: \(scoreValue)")
            }
            .alert(scoreTitle ,isPresented: $showingReset) {
                Button("Reset", action: resetGame)
            } message: {
                Text("8 tries now reset")
                
                Text("your score is: \(scoreValue)")
            }
        }
    }
    
    func resetGame() {
        showingScore = false
        scoreTitle = ""
        scoreValue = 0
        
        countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria",
                         "Poland", "Russia", "Spain", "UK", "US"].shuffled()
        correctAnswer = Int.random(in: 0...2)
        flagSelected = 0
        guessed = 0
        showingReset = false
    }
    
    func flagTapped(_ number: Int) {
        flagSelected = number
        guessed += 1
        
        if guessed < 8 {
            if number == correctAnswer {
                scoreTitle = "Correct"
                scoreValue += 1
            } else {
                scoreTitle = "Wrong"
            }
            showingScore = true
        } else {
            showingReset = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct StackingButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        StackingButtonsView()
    }
}
