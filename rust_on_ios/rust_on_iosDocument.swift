//
//  rust_on_iosDocument.swift
//  rust_on_ios
//
//  Created by Nathan Henrie on 2022-09-22.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var exampleText: UTType {
        UTType(importedAs: "com.example.plain-text")
    }
}

struct rust_on_iosDocument: FileDocument {
    var text: String

    init(text: String = String.init(cString: hello_rust())) {

        let answer = add_numbers(15, 25)
        print("The answer is: \(answer)")
        let string = "for an anvil, this library sure is lightweight"
        print("The length is: \(string_length(string))")

        let colour = what_colour()
        if colour == Green {
            print("go")
        } else {
            print("stop")
        }

        let word1 = "agreeable"
        let word2 = "affable"
        let distance = leven(word1, word2)
        print("Length: \(distance)")

        print("Adding numbers with callback...")
        add_numbers_cb(4, 5) {
            answer in
            print("The answer is \(answer)")
        }
        print("Finished adding numbers!")

        countdown() {
            (timer: Int32) in

            // Uh oh
            if timer == 7 {
                print("Aborting!")
                return Abort
            }

            if timer > 0 {
                print("\(timer) seconds to go...")
            } else {
                print("Houston we have liftoff")
            }
            return Continue
        }

        self.text = text
    }

    static var readableContentTypes: [UTType] { [.exampleText] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
