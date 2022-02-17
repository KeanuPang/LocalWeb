import Hummingbird
import HummingbirdFoundation

typealias ServerHost = String
typealias ServerPort = Int

enum Server {
    static func run(host: ServerHost, port: ServerPort, root: ServerRootPath) throws {
        let app = HBApplication(
            configuration: .init(
                address: .hostname(host, port: port),
                serverName: "LocalWeb File Server"
            )
        )

        app.middleware.add(DirectoryIndexMiddleware(root, application: app))
        app.middleware.add(HBFileMiddleware(root, application: app))
        app.middleware.add(HBLogRequestsMiddleware(.info))

        try app.start()
        app.wait()
    }
}

let localIP = NetworkHelper.getIPAddress() ?? "127.0.0.1"

try Server.run(host: "0.0.0.0", port: 7920, root: "/Users/keanupang/Workshop/98. Temp/swift-web")
