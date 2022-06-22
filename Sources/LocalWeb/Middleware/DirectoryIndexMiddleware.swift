//
//  DirectoryIndexMiddleware.swift
//
//
//  Created by Keanu Pang on 2022/2/17.
//

import Files
import Foundation
import HummingbirdFoundation

public struct DirectoryIndexMiddleware: HBMiddleware {
    let rootFolder: String

    public init(_ rootFolder: String, application: HBApplication) {
        self.rootFolder = rootFolder.last == "/" ? String(rootFolder.dropLast()) : rootFolder
    }

    public func apply(to request: HBRequest, next: HBResponder) -> EventLoopFuture<HBResponse> {
        return next.respond(to: request).flatMapError { error in
            guard let httpError = error as? HBHTTPError, httpError.status == .notFound else {
                return request.failure(error)
            }

            guard let path = request.uri.path.removingPercentEncoding else {
                return request.failure(.badRequest)
            }

            guard !path.contains("..") else {
                return request.failure(.badRequest)
            }

            let fullPath = rootFolder + path

            do {
                let attributes = try FileManager.default.attributesOfItem(atPath: fullPath)

                if let fileType = attributes[.type] as? FileAttributeType, fileType == .typeDirectory {
                    let folders = (try? Folder(path: fullPath).subfolders.map { $0.name }) ?? [String]()
                    let files = (try? Folder(path: fullPath).files.map { $0.name }) ?? [String]()

                    return request.success(DirectoryIndexPage(rootFolder: rootFolder, path: path, folders: folders, files: files).response(from: request))
                }

                return request.failure(.badRequest)
            } catch {
                return request.failure(.notFound)
            }
        }
    }
}
