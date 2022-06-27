import Files
import Hummingbird
import HummingbirdFoundation
import HummingbirdTLS

typealias ServerHost = String
typealias ServerPort = Int
typealias ServerRootPath = String

struct ServerOptions {
    var host: ServerHost
    var port: ServerPort
    var root: ServerRootPath

    var certFile: String
    var certKey: String
}

enum Server {
    static func run(option: ServerOptions) throws {
        let app = HBApplication(
            configuration: .init(
                address: .hostname(option.host, port: option.port),
                serverName: "LocalWeb File Server",
                tlsOptions: TSTLSOptions.none
            )
        )

        app.middleware.add(DirectoryIndexMiddleware(option.root, application: app))
        app.middleware.add(HBFileMiddleware(option.root, searchForIndexHtml: true, application: app))
        app.middleware.add(HBLogRequestsMiddleware(.info))

        let tlsConfig = try Server.getTLSConfiguration(certFile: option.certFile, certKey: option.certKey)
        if let t = tlsConfig {
            try app.server.addTLS(tlsConfiguration: t)
        }

        try app.start()

        app.logger.info("URL for browser: http\(tlsConfig == nil ? "" : "s")://\(option.host):\(option.port)")
        app.logger.info("Server rootpath: \(option.root)")

        app.wait()
    }

    private static func getTLSConfiguration(certFile: String, certKey: String) throws -> TLSConfiguration? {
        guard let certFile = try? File(path: certFile).readAsString(),
              let keyFile = try? File(path: certKey).readAsString()
        else { return nil }

        let certificate = try NIOSSLCertificate(bytes: [UInt8](certFile.utf8), format: .pem)
        let privateKey = try NIOSSLPrivateKey(bytes: [UInt8](keyFile.utf8), format: .pem)

        return TLSConfiguration.makeServerConfiguration(certificateChain: [.certificate(certificate)], privateKey: .privateKey(privateKey))
    }
}
