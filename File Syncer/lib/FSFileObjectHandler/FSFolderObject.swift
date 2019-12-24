//
//  FolderManager.swift
//  File Syncer
//
//  Created by Yamazaki Keisuke on 2019/12/16.
//  Copyright © 2019 Yamazaki Keisuke. All rights reserved.
//

import Foundation

class FSFolderObject: FSAbstractFileEntry {
    
    override init(path: String, fileAttribute: [FileAttributeKey: Any]) {
        super.init(path: path, fileAttribute: fileAttribute);
        self.getAllFilesInFolder();
    }

    func getAllFilesInFolder() {
        do {
            let _path = try FileManager.default.contentsOfDirectory(atPath: self.path);
            self.fileList = _path.map { self.path + "/" + $0 }
                                .compactMap { FSAbstractFileEntry.createFileObject(path: $0) }
        } catch {
        }
    }
    
}
