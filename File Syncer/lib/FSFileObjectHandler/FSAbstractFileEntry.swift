//
//  FileEntry.swift
//  File Syncer
//
//  Created by Yamazaki Keisuke on 2019/12/20.
//  Copyright © 2019 Yamazaki Keisuke. All rights reserved.
//

import Foundation
import Cocoa

class FSAbstractFileEntry : NSObject {
    let path: String;
    @objc dynamic let fileName: String;
    let fileAttribute: [FileAttributeKey: Any];
    var fileList = [FSAbstractFileEntry]();
    @objc let image: NSImage;
    @objc let isSync = true;

    // @objc dynamic var fileIcon: NSImagegeName;
    // NSImageNameFolderBurnable
    
    init(path: String, fileAttribute: [FileAttributeKey: Any]) {
        self.path = path;
        self.image = NSWorkspace.shared.icon(forFile: self.path);
        self.fileName = ((path as NSString).lastPathComponent as String);
        self.fileAttribute = fileAttribute;
    };

    // ファイルのタイプにより、生成する派生クラスを分けている(static factory method)
    static func createFileObject(path: String) -> FSAbstractFileEntry? {
        if let _fileAttribute = self.getFileAttribute(path: path) {
            if let _fileType = _fileAttribute[FileAttributeKey.type] as? String {
                switch (_fileType) {
                    case "NSFileTypeDirectory":
                        return FSFolderObject.init(path: path, fileAttribute: _fileAttribute);
                    default:
                        return FSFileObject.init(path: path, fileAttribute: _fileAttribute);
                }
            }
        }
        return nil
    };
    
    static func getFileAttribute(path: String) -> [FileAttributeKey: Any]? {
        do {
            let _fileAttribute = try FileManager.default.attributesOfItem(atPath: path);
            return _fileAttribute;
        } catch let error as NSError {
            print(error)
            return nil;
        }
    };
    
    static func isFolder(path: String) -> Bool {
        if let _fileAttribute = self.getFileAttribute(path: path) {
            if let _fileType = _fileAttribute[FileAttributeKey.type] as? String {
                return _fileType == "NSFileTypeDirectory" ? true : false;
            }
        }
        return false;
    };
    
    /*
    // TreeControllerのためのオブジェクト
    // ここから
    */
    @objc func isLeaf() -> Bool {
        return self.fileList.isEmpty
    };
    
    @objc func childCount() -> Int {
        return self.fileList.count;
    };
    
    @objc func myChildren() -> [FSAbstractFileEntry] {
        return self.fileList;
    }
    // ここまで

}
