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
    let fileAttribute: [FileAttributeKey: Any];
    var fileList = [FSAbstractFileEntry]();
    let rootFolderPath:String;
    @objc dynamic let fileName: String;
    @objc dynamic let image: NSImage;
    // didsetを使用して監視する
    // フォルダリストは以下のチェックボックスを再帰的に変更する
    @objc dynamic var isSync = true {
        didSet {
            print("test");
        }
    };


    init(path: String, rootFolderPath: String, fileAttribute: [FileAttributeKey: Any]) {
        self.path = path;
        self.rootFolderPath = rootFolderPath;
        self.image = NSWorkspace.shared.icon(forFile: self.path);
        self.fileName = ((path as NSString).lastPathComponent as String);
        self.fileAttribute = fileAttribute;
    };

    // ファイルのタイプにより、生成する派生クラスを分けている(static factory method)
    static func createFileObject(path: String, rootFolderPath: String) -> FSAbstractFileEntry? {
        // guard let の方が見やすいかもしれない
        if let _fileAttribute = self.getFileAttribute(path: path) {
            if let _fileType = _fileAttribute[FileAttributeKey.type] as? String {
                switch (_fileType) {
                    case "NSFileTypeDirectory":
                        return FSFolderObject.init(path: path, rootFolderPath: rootFolderPath, fileAttribute: _fileAttribute);
                    default:
                        return FSFileObject.init(path: path, rootFolderPath: rootFolderPath, fileAttribute: _fileAttribute);
                }
            }
        }
        return nil
    };
    
    func getPathFromRootFolderPath() -> String {
        return self.path.replacingOccurrences(of: self.rootFolderPath, with: "");
    };
    
    static func getFileAttribute(path: String) -> [FileAttributeKey: Any]? {
        do {
            let _fileAttribute = try FileManager.default.attributesOfItem(atPath: path);
            return _fileAttribute;
        } catch let _error as NSError {
            print(_error)
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
