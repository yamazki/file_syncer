//
//  File.swift
//  File Syncer
//
//  Created by Yamazaki Keisuke on 2019/11/24.
//  Copyright © 2019 Yamazaki Keisuke. All rights reserved.
//

import Foundation
import Cocoa

class Dialog: NSObject {
    class func selectDirectory() -> String {
        let openPanel = NSOpenPanel();
        openPanel.canChooseDirectories = true;
        openPanel.canChooseFiles = false;
        openPanel.canCreateDirectories = false;
        openPanel.allowsMultipleSelection = false;
        if( openPanel.runModal() == NSApplication.ModalResponse.OK ) {
            if let panelURL = openPanel.url {
                return panelURL.path;
            }
        }
        return "";
    }
    
}

