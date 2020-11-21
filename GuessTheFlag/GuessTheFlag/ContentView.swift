//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dave Spina on 11/20/20.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    @State private var name = ""
    var body: some View {
        ZStack {
            // Color.. acts as a view
            //Color.init(red: 0.1, green: 0.2, blue: 0.4).ignoresSafeArea(edges: .all)
            // gradients
            // other gradients are LinearGradient, CircularGradient
            AngularGradient(gradient: Gradient(colors: [.red, .purple, .pink, .orange, .yellow, .blue]), center: .center).ignoresSafeArea(edges: .all)
            VStack(spacing: 20) {
                HStack {
                    VStack(spacing: 20) {
                        Text("Cell 1a")
                        Text("Cell 1b")
                        Text("Cell 1c")
                    }
                
                    VStack(spacing: 20) {
                        Text("Cell 2a").background(Color.green)
                        Text("Cell 2b")
                        Text("Cell 2c")
                    }
                    VStack(spacing: 20) {
                        Text("Cell 3a")
                        Text("Cell 3b")
                        Text("Cell 3c")
                    }
                    VStack{
                        Color.blue.frame(width: 100, height: 100)
                        Text("This appears below the box")
                    }
                    Spacer()
                }
                
                TextField("Enter name", text: $name)
                // Buttons
                Button(action: {
                    print("Button was pressed!")
                    self.showAlert = true
                }) {
                    HStack (spacing: 5) {
                        Image(systemName: "pencil")
                        Text("Something Here")
                    }
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Greetings"), message: Text("Hello \(self.name)"), dismissButton: .default(Text("Okee Dokee")))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
