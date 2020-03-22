//
//  DocumentBrowserViewController.swift
//  Code
//
//  Created by Andrew McWatters on 3/21/20.
//  Copyright © 2020 Andrew McWatters. All rights reserved.
//

import UIKit
import SwiftUI

class DocumentBrowserViewController: UIDocumentBrowserViewController, UIDocumentBrowserViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        allowsDocumentCreation = true
        allowsPickingMultipleItems = false
        
        // Update the style of the UIDocumentBrowserViewController
        // browserUserInterfaceStyle = .dark
        // view.tintColor = .white
        
        // Specify the allowed content types of your application via the Info.plist.
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: UIDocumentBrowserViewControllerDelegate
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didRequestDocumentCreationWithHandler importHandler: @escaping (URL?, UIDocumentBrowserViewController.ImportMode) -> Void) {
            
        let doc = Document()
        let url = doc.fileURL
        
        // Create a new document in a temporary location
        doc.save(to: url, for: .forCreating) { (saveSuccess) in
            
            // Make sure the document saved successfully
            guard saveSuccess else {
                // Cancel document creation
                importHandler(nil, .none)
                return
            }
            
            // Close the document.
            doc.close(completionHandler: { (closeSuccess) in
                
                // Make sure the document closed successfully
                guard closeSuccess else {
                    // Cancel document creation
                    importHandler(nil, .none)
                    return
                }
                
                // Pass the document's temporary URL to the import handler.
                importHandler(url, .move)
            })
        }
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentsAt documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return }
        
        // Present the Document View Controller for the first document that was picked.
        // If you support picking multiple items, make sure you handle them all.
        presentDocument(at: sourceURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, didImportDocumentAt sourceURL: URL, toDestinationURL destinationURL: URL) {
        // Present the Document View Controller for the new newly created document
        presentDocument(at: destinationURL)
    }
    
    func documentBrowser(_ controller: UIDocumentBrowserViewController, failedToImportDocumentAt documentURL: URL, error: Error?) {
        // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
    }
    
    // MARK: Document Presentation
    
    var transitionController: UIDocumentBrowserTransitionController?
    
    func presentDocument(at documentURL: URL) {
        let document = Document(fileURL: documentURL)

        // Access the document
        document.open(completionHandler: { success in
            if success {
                // Display the content of the document:
                let view = DocumentView(document: document, dismiss: {
                    self.closeDocument(document)
                })

                let documentViewController = UIHostingController(rootView: view)

                // In order to get a proper animation when opening and closing documents, the DocumentViewController needs a custom view controller
                // transition. The `UIDocumentBrowserViewController` provides a `transitionController`, which takes care of the zoom animation. Therefore, the
                // `UIDocumentBrowserViewController` is registered as the `transitioningDelegate` of the `DocumentViewController`. Next, obtain the
                // transitionController, and store it for later (see `animationController(forPresented:presenting:source:)` and
                // `animationController(forDismissed:)`).
                documentViewController.transitioningDelegate = self

                // Get the transition controller.
                self.transitionController = self.transitionController(forDocumentAt: documentURL)
                
                // Present this document (and it's navigation controller) as full screen.
                documentViewController.modalPresentationStyle = .fullScreen

                self.present(documentViewController, animated: true, completion: nil)
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }

    func closeDocument(_ document: Document) {
        dismiss(animated: true) {
            document.close(completionHandler: nil)
        }
    }
}

extension DocumentBrowserViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // Since the `UIDocumentBrowserViewController` has been set up to be the transitioning delegate of `DocumentViewController` instances (see
        // implementation of `presentDocument(at:)`), it is being asked for a transition controller.
        // Therefore, return the transition controller, that previously was obtained from the `UIDocumentBrowserViewController` when a
        // `DocumentViewController` instance was presented.
        return transitionController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // The same zoom transition is needed when closing documents and returning to the `UIDocumentBrowserViewController`, which is why the the
        // existing transition controller is returned here as well.
        return transitionController
    }
    
}

