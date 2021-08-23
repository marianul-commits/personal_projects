//
//  SettingsModal.swift
//  scaliir-Try
//
//  Created by Marian Nasturica on 06.08.2021.
//

import SwiftUI

struct SettingsModal: View{
    
    @Binding var row: String
    @Binding var column: String
    @Binding var colour: Color
    @Binding var isPresented: Bool
    @State var animation = true
    @State private var save = ""
    @State private var showingAlert = false

    var body: some View {
        
        
        VStack{
            Text("Grid Settings").font(.title2)
            Text(" ").font(.title2)
            Text(" ").font(.title2)
            VStack{
                
                //Grid Dimension
                HStack{
                    Text("Rows      ")
                    TextField("Number of rows", text: $row)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                }.padding(.horizontal)
                
                HStack{
                    Text("Columns")
                    TextField("Number of columns", text: $column)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                }.padding(.horizontal)
                
            }
            
            //Grid Color
            ColorPicker("Set the grid's color", selection: $colour, supportsOpacity: false)
                .padding(.vertical, 40)
                .padding(.horizontal)
            
            Button (action:
                        {
                            self.isPresented = false
                        }){
                Text("X")
                    .font(.system(size: 20))
                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(15)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }
            }
        }
    }
    
    struct SettingsModal_Previews: PreviewProvider {
        static var previews: some View {
            SettingsModal(row: .constant(""), column: .constant(""), colour: .constant(Color.black), isPresented: .constant(false))
        }
    }

