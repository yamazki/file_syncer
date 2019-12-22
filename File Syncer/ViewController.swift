//
//  ViewController.swift
//  File Syncer
//
//  Created by Yamazaki Keisuke on 2019/11/17.
//  Copyright © 2019 Yamazaki Keisuke. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var textField1: NSTextField!
    @IBOutlet var textField2: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func selectDirectoryButton1(_ sender : Any) {
        textField1.stringValue = Dialog.selectDirectory();
        let _path = textField1.stringValue;
        
        let pathIsFolder = FSAbstractFileEntry.isFolder(path: _path);
        if (pathIsFolder == false) {
            return;
        }
            

        if let folderObject1 = FSAbstractFileEntry.createFileObject(path: _path) {
            

        }
        // FolderObject.init(folderPath: textField1.stringValue);
    }
    
    @IBAction func selectDirectoryButton2(_ sender : Any) {
        textField2.stringValue = Dialog.selectDirectory();
    }

}

