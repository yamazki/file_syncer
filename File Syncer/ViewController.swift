//
//  ViewController.swift
//  File Syncer
//
//  Created by Yamazaki Keisuke on 2019/11/17.
//  Copyright © 2019 Yamazaki Keisuke. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var textField1: NSTextField!;
    @IBOutlet var textField2: NSTextField!;
    @IBOutlet var treeController: NSTreeController!;
    @IBOutlet var outlineView: NSOutlineView!;
    
    @objc dynamic var folderObject1: FSAbstractFileEntry?;

    var fileName = "test";

    override func viewDidLoad() {
        print(self)
        super.viewDidLoad();
        treeController.content = self.folderObject1;
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func selectDirectoryButton1(_ sender : Any) {
        self.textField1.stringValue = Dialog.selectDirectory();
        let _path = self.textField1.stringValue;
        
        let _pathIsFolder = FSAbstractFileEntry.isFolder(path: _path);
        if (_pathIsFolder == false) {
            return;
        }
            
        self.folderObject1 = FSAbstractFileEntry.createFileObject(path: _path);
        self.outlineView.reloadItem(self, reloadChildren: true);


        // FolderObject.init(folderPath: textField1.stringValue);
    }
    
    @IBAction func selectDirectoryButton2(_ sender : Any) {
        self.textField2.stringValue = Dialog.selectDirectory();
    }

}

