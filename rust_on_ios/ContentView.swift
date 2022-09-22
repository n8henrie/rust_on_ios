//
//  ContentView.swift
//  rust_on_ios
//
//  Created by Nathan Henrie on 2022-09-22.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: rust_on_iosDocument
    
    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(rust_on_iosDocument()))
    }
}
