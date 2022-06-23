import Files
import Foundation
import Hummingbird
import HummingbirdFoundation

typealias ServerHost = String
typealias ServerPort = Int
typealias ServerRootPath = String

enum Server {
    static func run(host: ServerHost, port: ServerPort, root: ServerRootPath) throws {
        let tls = TSTLSOptions.options(serverIdentity: .p12(filename: "", password: "")) ?? .none
        let app = HBApplication(
            configuration: .init(
                address: .hostname(host, port: port),
                serverName: "LocalWeb File Server",
                tlsOptions: tls
            )
        )

        app.middleware.add(DirectoryIndexMiddleware(root, application: app))
        app.middleware.add(HBFileMiddleware(root, searchForIndexHtml: true, application: app))
        app.middleware.add(HBLogRequestsMiddleware(.info))

        try app.start()

        app.logger.info("URL for browser: http://\(host):\(port)")
        app.logger.info("Server rootpath: \(root)")
        app.wait()
    }
}
