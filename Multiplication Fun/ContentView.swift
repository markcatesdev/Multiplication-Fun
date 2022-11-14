//
//  ContentView.swift
//  Multiplication Fun
//
//  Created by Mark Cates on 11/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var multiplyAmount = 2
    @State private var numQuestions = 5
    @State private var userAnswer = 0
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var showQuestions = false
    @State private var currentQuestion = 0
    @State private var correctAnswer = 0
    @State private var updatedRanges = allRanges.shuffled()
    static let allRanges = [2,3,4,5,6,7,8,9,10,11,12]
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    Section {
                        Stepper("\(multiplyAmount)", value: $multiplyAmount, in: 2...12)
                    }
                    Section {
                        Stepper("\(numQuestions)", value: $numQuestions, in: 5...20, step: 5)
                    }
                    Section {
                        Button("Play", action: playGame)
                    }
                    .toolbar {
                        Button("New Game", action: newGame)
                    }
                    .onAppear(perform: newGame)
                    
                    
                    if showQuestions {
                        VStack {
                            Section {
                                Text("What is \(multiplyAmount) * \(updatedRanges[currentQuestion])? ")
                            }
                            Section {
                                TextField("", value: $userAnswer, format: .number)
                                    .padding(5.0)
                                    .background(Color.gray.opacity(0.2))
                            }
                        }
                    }
                }
                .onSubmit(checkAnswer)
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                    
                } message: {
                    Text("Your score is \(score)")
                }
            }
        }
        
    }
    
    func askQuestion() {
        currentQuestion += 1
        showingScore = false
    }
    
    func newGame() {
        multiplyAmount = 2
        numQuestions = 5
        showQuestions = false
    }
    
    func playGame() {
        updatedRanges = Self.allRanges
        updatedRanges.shuffle()
        currentQuestion = 0
        showQuestions = true
    }
    
    func checkAnswer() {
        if userAnswer == multiplyAmount * updatedRanges[currentQuestion] {
            score += 1
        } else {
            score -= 1
        }
        showingScore = true
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
