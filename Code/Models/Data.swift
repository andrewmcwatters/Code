//
//  Data.swift
//  Code
//
//  Created by Andrew McWatters on 3/22/20.
//  Copyright © 2020 Andrew McWatters. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation

let documentData: Document = load("Untitled.txt")

func load(_ filename: String) -> Document {
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    return Document(fileURL: file)
}

