//
//  DocumentView.swift
//  Code
//
//  Created by Andrew McWatters on 3/21/20.
//  Copyright © 2020 Andrew McWatters. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
        textView.textContainer.lineBreakMode = .byCharWrapping
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<TextView>) {
        uiView.text = text
    }
}

struct DocumentView: View {
    var document: UIDocument
    var dismiss: () -> Void
    @State var text: String = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    
    var body: some View {
        NavigationView {
            TextView(text: $text)
                .navigationBarTitle(
                    Text(document.fileURL.lastPathComponent),
                    displayMode: .inline
                )
                .navigationBarItems(leading: Button("Done", action: dismiss))
        }
    }
}

struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView(document: documentData, dismiss: {
            
        })
    }
}
