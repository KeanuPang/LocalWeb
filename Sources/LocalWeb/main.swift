import Hummingbird
import HummingbirdFoundation

typealias ServerHost = String
typealias ServerPort = Int
typealias ServerRoot = String

enum Server {
    static func run(host: ServerHost, port: ServerPort, root: ServerRoot) throws {
        let app = HBApplication(
            configuration: .init(
                address: .hostname(host, port: port),
                serverName: "LocalWeb File Server"
            )
        )

        let fileMiddleware = HBFileMiddleware(root, cacheControl: HBCacheControl([]), searchForIndexHtml: true, application: app)
        app.middleware.add(fileMiddleware)
        app.middleware.add(HBLogRequestsMiddleware(.info))

        try app.start()
        app.wait()
    }
}

try Server.run(host: "127.0.0.1", port: 7920, root: "/Users/keanupang/Workshop/98. Temp/swift-web")
