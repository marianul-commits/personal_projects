//
//  ContentView.swift
//  scaliir-Try
//
//  Created by Marian Nasturica on 05.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var isHidden = true
    @State private var row: String = ""
    @State private var column: String = ""
    @State private var color: Color = Color.black
    @State private var isPresented: Bool = false
    private lazy var rowS = Int(row) ?? 32
    private lazy var colS = Int(column) ?? 32
    
    func rowV() -> Int {
        var mutatableSelf = self
        return mutatableSelf.rowS
    }
    func colV() -> Int {
        var mutatableSelf = self
        return mutatableSelf.colS
    }
    
    //Displayed Image with Grid Overlay
    var gridView: some View{
        ZStack{
            Image(uiImage: self.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
                // Checkerboard Grid
                .overlay(
                    Checkerboard(rows: rowV(), columns: colV())
                        .stroke(color)
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .opacity(isHidden ? 0 : 1))
        }
    }
    
    var buttonsView: some View{
        HStack{
            //Open Library & Select
            Button (action:
                        {
                            self.isShowPhotoLibrary = true
                        }){
                Image(systemName: "plus")
                    .font(.system(size: 20))
                    .padding()
                    .background(Color.green)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.green, lineWidth: 4)
                    )
                    .contentShape(Circle())
                
            }.offset(x: 0, y: 300)
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
            //Save Image
            Button (action:
                        {
                            let snap = gridView.snapshot()
                            UIImageWriteToSavedPhotosAlbum(snap, nil, nil, nil)
                        }){
                Image(systemName: "square.and.arrow.down")
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.blue, lineWidth: 4)
                    )
                    .contentShape(Circle())
            }.offset(x: 45, y: 300)
            
            
            // Settings
            Button (action:
                        {
                            self.isPresented.toggle()
                        }){
                Image(systemName: "gear")
                    .font(.system(size: 20))
                    .frame(width: 50, height: 50)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding()
                    .contentShape(Circle())
            }.sheet(isPresented: $isPresented){
                SettingsModal(row: self.$row, column: self.$column, colour: self.$color, isPresented: self.$isPresented)
            }
            .offset(x: 90, y: -340)
            // Toggle Grid
            Button (action:
                        {
                            isHidden.toggle()
                        }){
                Image(systemName: "square")
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.purple, lineWidth: 4)
                    )
                    .contentShape(Circle())
            }
            .offset(x: 0, y: 300)
        }
    }
    
    var body: some View {
        ZStack{
            gridView
            buttonsView
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
