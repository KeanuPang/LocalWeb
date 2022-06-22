import Files
import Foundation
import Hummingbird
import HummingbirdFoundation
import SwiftDotenv

typealias ServerHost = String
typealias ServerPort = Int

let env = try? Dotenv.load(path: ".env")

func getServerHost() -> ServerHost {
    env?["serverHost"]?.stringValue ?? "localhost"
}

func getServerPort() -> ServerPort {
    Int(env?["serverPort"]?.stringValue ?? "") ?? 7920
}

func getRootFolder() -> String {
    return (env?["rootFolder"]?.stringValue) ?? FileManager.default.currentDirectoryPath
}

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
        app.middleware.add(HBFileMiddleware(root, application: app))
        app.middleware.add(HBLogRequestsMiddleware(.info))

        try app.start()
        app.wait()
    }
}

try Server.run(host: getServerHost(), port: getServerPort(), root: getRootFolder())
