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

    var body: some View {
        VStack {
            HStack {
                Text("File Name")
                    .foregroundColor(.secondary)

                Text(document.fileURL.lastPathComponent)
            }

            Button("Done", action: dismiss)
        }
    }
}

struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView(document: documentData, dismiss: {
            
        })
    }
}
