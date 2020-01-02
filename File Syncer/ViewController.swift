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
    @objc dynamic var folderObjectList1 = [FSAbstractFileEntry]();

    override func viewDidLoad() {
        super.viewDidLoad();
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func selectDirectoryButton1(_ sender : Any) {
        
        guard let _path = Dialog.selectDirectory() else {
            return;
        }

        self.textField1.stringValue = _path;

        let _pathIsFolder = FSAbstractFileEntry.isFolder(path: _path);
        if (_pathIsFolder == false) {
            return;
        }
            
        self.folderObject1 = FSAbstractFileEntry.createFileObject(path: _path, rootFolderPath: _path);
        self.folderObjectList1 = self.folderObject1!.fileList;
        self.folderObjectList1.removeAll();
        self.folderObjectList1.append(self.folderObject1!);
        self.outlineView.expandItem(nil, expandChildren: true)

        // FolderObject.init(folderPath: textField1.stringValue);
    }
    
    @IBAction func selectDirectoryButton2(_ sender : Any) {
    }
    
    // class func get
    
}

