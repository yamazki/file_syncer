//
//  FolderManager.swift
//  File Syncer
//
//  Created by Yamazaki Keisuke on 2019/12/16.
//  Copyright © 2019 Yamazaki Keisuke. All rights reserved.
//

import Foundation

class FSFolderObject: FSAbstractFileEntry {
    
    override init(path: String, rootFolderPath: String,fileAttribute: [FileAttributeKey: Any]) {
        super.init(path: path, rootFolderPath: rootFolderPath, fileAttribute: fileAttribute);
        self.getAllFilesInFolder();
    }

    func getAllFilesInFolder() {
        do {
            let _path = try FileManager.default.contentsOfDirectory(atPath: self.path);
                _path.map { ((self.path as NSString).appendingPathComponent($0) as String) }
                     .compactMap { FSAbstractFileEntry.createFileObject(path: $0, rootFolderPath: self.rootFolderPath) }
                     .forEach {self.fileList.append($0)};
            
        } catch let error as NSError {
            print(error);
        }
    }
    
}
