//  Created by Lucas Real Dias on 04/04/23.

import SwiftUI

struct ContentView: View {
    
    @State private var choises = ["🖐", "✌️", "✊"]
    
    @State private var shouldWin = Bool.random() ? "Win" : "Lose"
    @State private var appChoise = Int.random(in: 0..<3)
    @State private var userChoise = 0
    @State private var titleResult = ""
    @State private var score = 0
    @State private var counter = 0
    
    @State private var showAlert = false
    @State private var showFinalAlert = false
    
    private var correctAnwser: Int {
        return (shouldWin == "Win") ? ((appChoise + 1) % 3) : ((appChoise + 2) % 3)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("darkGrey"), Color("lightGrey")], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack {
                Text("Computer choise")
                    .foregroundColor(Color("lightGrey"))
                    .font(.system(size: 45).weight(.light))
                    .padding(.top, 50)
                
                Text(choises[appChoise])
                    .padding(10)
                    .font(.system(size: 80))
                    .background(Color("lightGrey"))
                    .cornerRadius(10)
                
                HStack {
                    Text("Should:")
                    
                    Text("\(shouldWin)")
                        .padding(5)
                        .foregroundColor(.yellow)
                        .background(.gray)
                        .cornerRadius(10)
                }
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .background(Color("lightGrey"))
                    .font(.system(size: 30).weight(.light))
                    .foregroundColor(.gray)
                    .padding(.top, 30)
                
                Spacer()
                Text("Your choise")
                    .foregroundColor(Color("lightGrey"))
                    .font(.system(size: 42).weight(.light))
                    .padding(.bottom, -7)
                
                HStack {
                    ForEach(0..<3, id: \.self) { index in
                        Button {
                            runApp(index)
                        } label: {
                            Text(choises[index])
                                .padding(5)
                                .font(.system(size: 80))
                                .background(Color("lightGrey"))
                                .cornerRadius(10)
                                .padding(10)
                        }
                    }
                }
                
                Spacer()
                Group {
                    HStack {
                        Text("Score:")
                        
                        Text("\(score)")
                            .padding(5)
                            .foregroundColor(.yellow)
                            .background(.gray)
                            .cornerRadius(10)
                    }
                    
                    HStack {
                        Text("Counter:")
                        
                        Text("\(counter)")
                            .padding(5)
                            .foregroundColor(.yellow)
                            .background(.gray)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 20)
                }
                .foregroundColor(.gray).fontWeight(.light)
                .font(.system(size: 35))
            }
            
            .alert(titleResult, isPresented: $showAlert) {
                Button("Continue") {}
            } message: {
                Text("Score: \(score)")
            }
            
            .alert("End Game", isPresented: $showFinalAlert) {
                Button("Restart", action: reset)
            } message: {
                Text("Final Score: \(score)")
            }
        }
    }
    
    func runApp(_ userAnwser: Int) {
        if counter >= 9 {
            counter += 1
            score += 1
            showFinalAlert = true
        } else {
            if userAnwser == correctAnwser {
                titleResult = "Correct"
                score += 1
            } else if userAnwser != correctAnwser && score > 0  {
                titleResult = "Incorrect"
                score -= 1
            } else if userAnwser != correctAnwser && score == 0 {
                titleResult = "Incorrect"
            }
            counter += 1
            shouldWin = Bool.random() ? "Win" : "Lose"
            appChoise = Int.random(in: 0..<3)
            showAlert = true
        }
    }
    
    func reset() {
        counter = 0
        score = 0
        shouldWin = Bool.random() ? "Win" : "Lose"
        appChoise = Int.random(in: 0..<3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
