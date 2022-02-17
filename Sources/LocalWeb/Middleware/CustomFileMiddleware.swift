//
//  CustomFileMiddleware.swift
//
//
//  Created by Keanu Pang on 2022/2/16.
//

import HummingbirdFoundation

struct HTML: HBResponseGenerator {
    let html: String

    public func response(from request: HBRequest) throws -> HBResponse {
        let buffer = request.allocator.buffer(string: self.html)
        return .init(status: .ok, headers: ["content-type": "text/html"], body: .byteBuffer(buffer))
    }
}

extension HBFileMiddleware {
    func setupDirectoryIndex(app: HBApplication) {
        app.router.get("/") { _ -> HTML in

            let html = """
            <html>
            <head><title>Index of /</title></head>
            <body>
            <h1>Index of /</h1>

            <p>
                <strong><a href="/jena/">Parent Directory</a></strong>
            </p>
            <a href="jena-4.2.0-source-release.zip">jena-4.2.0-source-release.zip</a>
            <hr />
            </body></html>

            """

            return HTML(html: html)
        }
    }
}
