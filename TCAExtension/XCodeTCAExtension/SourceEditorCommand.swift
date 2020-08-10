//
//  SourceEditorCommand.swift
//  XCodeTCAExtension
//
//  Created by Van Simmons on 8/10/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        completionHandler(nil)
    }
    
}
