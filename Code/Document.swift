//
//  Document.swift
//  Code
//
//  Created by Andrew McWatters on 3/21/20.
//  Copyright © 2020 Andrew McWatters. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    public var text: String = ""

    override init(fileURL url: URL) {
        super.init(fileURL: url)
    }
    
    init() {
        let tempDir = FileManager.default.temporaryDirectory
        let url = tempDir.appendingPathComponent("Untitled.txt")
        
        super.init(fileURL: url)
    }
    
    override func contents(forType typeName: String) throws -> Any {
        return text.data(using: .utf8) as Any
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        text = String(data: contents as! Data, encoding: .utf8)!
    }
}

