//
//  DocumentView.swift
//  Code
//
//  Created by Andrew McWatters on 3/21/20.
//  Copyright © 2020 Andrew McWatters. All rights reserved.
//

import SwiftUI

struct DocumentView: View {
    var document: UIDocument
    var dismiss: () -> Void
    @State private var text: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("", text: $text)
            }
            .navigationBarTitle(
                Text(document.fileURL.lastPathComponent),
                displayMode: .inline
            )
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
    }
}

struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView(document: documentData, dismiss: {
            
        })
    }
}
