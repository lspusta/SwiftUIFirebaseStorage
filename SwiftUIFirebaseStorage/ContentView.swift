//
//  ContentView.swift
//  SwiftUIFirebaseStorage
//
//  Created by Lucas Spusta on 7/10/20.
//

import SwiftUI
import FirebaseStorage
import Combine

let IMAGE_FILE_NAME = "images/imageFileTest.jpg"

struct ContentView: View {
    @State var shown = false
    @State var imageURL = ""
    var body: some View {
        VStack {
            if imageURL != "" {
                FirebaseImageView(imageURL: imageURL)
            }
            
            
            
            Button(action: { self.shown.toggle() }) {
                Text("Upload Image").font(.title).bold()
            }.sheet(isPresented: $shown) {
                imagePicker(shown: self.$shown,imageURL: self.$imageURL)
                }.padding(5).background(Color.blue).foregroundColor(Color.white).cornerRadius(10)
        }.onAppear(perform: loadImageFromFirebase).animation(.spring())
    }
    
    func loadImageFromFirebase() {
        let storage = Storage.storage().reference(withPath: IMAGE_FILE_NAME)
        storage.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            print("Download success")
            self.imageURL = "\(url!)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
