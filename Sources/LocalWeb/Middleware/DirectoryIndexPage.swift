//
//  DirectoryIndexPage.swift
//
//
//  Created by Keanu Pang on 2022/2/16.
//

import Files
import Foundation
import HummingbirdFoundation

struct DirectoryIndexPage: HBResponseGenerator {
    var rootFolder: String
    var currentPath: String
    var folders: [String] = .init()
    var files: [String] = .init()

    init(rootFolder: String, path: String, folders: [String], files: [String]) {
        self.rootFolder = rootFolder
        self.currentPath = path.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if self.currentPath.count > 1, self.currentPath.last == "/" {
            self.currentPath = String(self.currentPath.dropLast())
        }

        self.folders = folders
        self.files = files
    }

    func response(from request: HBRequest) -> HBResponse {
        let buffer = request.allocator.buffer(string: self.toHtml())
        return .init(status: .ok, headers: ["content-type": "text/html; charset=utf-8"], body: .byteBuffer(buffer))
    }

    func toHtml() -> String {
        let linkPath = self.currentPath.last == "/" ? self.currentPath : self.currentPath + "/"
        let allPath = self.currentPath.components(separatedBy: "/")

        var navigation: String
        if allPath.last?.isEmpty == false {
            let link = allPath.dropLast().joined(separator: "/")

            navigation = """
            <p>
                <strong><a href="\(link.isEmpty ? "/" : link)">Parent Directory</a></strong>
            </p>
            """
        } else {
            navigation = ""
        }

        let folderList = folders.map {
            """
            <li><a href="\(linkPath)\($0)">\($0)/</a></li>
            """
        }.joined(separator: "")

        let fileList = files.map {
            """
            <li><a href="\(linkPath)\($0)">\($0)</a></li>
            """
        }.joined(separator: "")

        return """
        <html>
        <head><title>Index of \(self.currentPath)</title></head>
        <body>
        <h1>Index of \(self.currentPath)</h1>

        \(navigation)

        <ul>
        \(folderList)
        \(fileList)
        </ul>

        <hr />

        </body>
        </html>
        """
    }
}
