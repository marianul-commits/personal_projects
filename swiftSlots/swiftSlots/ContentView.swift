//
//  ContentView.swift
//  swiftSlots
//
//  Created by Marian Nasturica on 14.03.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var slot1 = Image("apple")
    @State private var slot2 = Image("apple")
    @State private var slot3 = Image("apple")
    @State private var creds = 5000
    @State private var gameOver = false
    @State private var gameOverButton = false
    
    var body: some View {
              
        VStack{
            Text("Swift Slots!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Spacer()
            
            if (creds > 0){
                Text("Credits:" + String(creds))
                    .font(.title2)
                    .fontWeight(.bold)
            }else {
                Text("Game Over!")
                    .font(.title2)
                    .fontWeight(.bold)
                
            }
            
            
            Spacer()
            
            HStack{
                Spacer()
                slot1
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                slot2
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                slot3
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            Spacer()
            
            Button(action: {
                
                let a = Int.random(in: 1...3)
                if a == 1 {
                    slot1 = Image("apple")
                }
                else if a == 2{
                    slot1 = Image("cherry")
                }
                else {
                    slot1 = Image("star")
                }
                let b = Int.random(in: 1...3)
                if b == 1 {
                    slot2 = Image("apple")
                }
                else if b == 2{
                    slot2 = Image("cherry")
                }
                else{
                    slot2 = Image("star")
                }
                let c = Int.random(in: 1...3)
                if c == 1 {
                    slot3 = Image("apple")
                }
                else if c == 2{
                    slot3 = Image("cherry")
                }
                else {
                    slot3 = Image("star")
                }

                if slot1 == slot2 && slot2 == slot3{
                    creds += 1
                } else if (creds < 0){
                    gameOver = true
                }
                else if (creds > 0){
                    creds = creds - 1000
                }
            }, label: {
                if (creds > 0){
                    Text("Spin")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 70.0)
                    .padding(.vertical, 20)
                    .background(Color.purple)
                        .cornerRadius(39.0)}
                else {
                    Text("Better luck next time!")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 70.0)
                        .padding(.vertical, 20)
                        .background(Color.gray)
                            .cornerRadius(39.0)}
            }).disabled(gameOver == true)
            
            Spacer()
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
