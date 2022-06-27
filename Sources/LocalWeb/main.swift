import ArgumentParser
import Foundation
import Hummingbird
import SwiftDotenv

let defaultAddress = "127.0.0.1"
let defaultPort = 7920
let defaultRoot = FileManager.default.currentDirectoryPath

let env = try? Dotenv.load(path: ".env")

private func getServerHost() -> ServerHost {
    env?["serverHost"]?.stringValue ?? defaultAddress
}

private func getServerPort() -> ServerPort {
    Int(env?["serverPort"]?.stringValue ?? "") ?? defaultPort
}

private func getRootFolder() -> ServerRootPath {
    return (env?["rootFolder"]?.stringValue) ?? FileManager.default.currentDirectoryPath
}

private func getCertFilePath() -> String {
    return env?["certFile"]?.stringValue ?? ""
}

private func getCertKeyPath() -> String {
    return env?["certKey"]?.stringValue ?? ""
}

struct HummingbirdArguments: ParsableCommand {
    @Option(name: .long)
    var host: ServerHost = getServerHost()

    @Option(name: .long)
    var port: ServerPort = getServerPort()

    @Option(name: .long)
    var root: ServerRootPath = getRootFolder()

    @Option(name: .long)
    var certFile: String = getCertFilePath()

    @Option(name: .long)
    var certKey: String = getCertKeyPath()

    func run() throws {
        try Server.run(option: ServerOptions(host: self.host,
                                             port: self.port,
                                             root: self.root,
                                             certFile: self.certFile,
                                             certKey: self.certKey))
    }
}

HummingbirdArguments.main()
