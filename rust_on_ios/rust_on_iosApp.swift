//
//  rust_on_iosApp.swift
//  rust_on_ios
//
//  Created by Nathan Henrie on 2022-09-22.
//

import SwiftUI

@main
struct rust_on_iosApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: rust_on_iosDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
