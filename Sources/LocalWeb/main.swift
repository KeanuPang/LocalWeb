import ArgumentParser
import Foundation
import Hummingbird
import SwiftDotenv

let defaultAddress = "127.0.0.1"
let defaultPort = 7920
let defaultRoot = FileManager.default.currentDirectoryPath

let env = try? Dotenv.load(path: ".env")

func getServerHost() -> ServerHost {
    env?["serverHost"]?.stringValue ?? defaultAddress
}

func getServerPort() -> ServerPort {
    Int(env?["serverPort"]?.stringValue ?? "") ?? defaultPort
}

func getRootFolder() -> ServerRootPath {
    return (env?["rootFolder"]?.stringValue) ?? FileManager.default.currentDirectoryPath
}

struct HummingbirdArguments: ParsableCommand {
    @Option(name: .long)
    var host: ServerHost = getServerHost()

    @Option(name: .long)
    var port: ServerPort = getServerPort()

    @Option(name: .long)
    var root: ServerRootPath = getRootFolder()

    func run() throws {
        try Server.run(host: self.host, port: self.port, root: self.root)
    }
}

HummingbirdArguments.main()
