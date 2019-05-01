import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import KituraOpenAPI
import Credentials
import CredentialsHTTP


public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
    let router = Router()
    let cloudEnv = CloudEnv()

    public init() throws {
        // Run the metrics initializer
        initializeMetrics(router: router)
    }

    func postInit() throws {
        // Endpoints
        initializeHealthRoutes(app: self)
        initializeEntryRoutes(app: self)
        initializeUserRoutes(app: self)
        //router.get("/entries", handler: helloWorldHandler)
        KituraOpenAPI.addEndpoints(to: router)
        Persistence.setUP()
        //initializeBasicAuth(app: self)
        
    }
    
    func helloWorldHandler(request: RouterRequest, response: RouterResponse, next: () ->()){
        response.headers.setType(MediaType.TopLevelType.text.rawValue)
        response.send("Hello, World!!!!")
        next()
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
//
//    func initializeBasicAuth(app: App) {
//        let authenticate = ["John": "12345", "Mary": "ABCDE"]
//        let credentials = Credentials()
//        let basicCredentials = CredentialsHTTPBasic(verifyPassword: { username, password, callback in
//            if let stroredPassword = authenticate[username], stroredPassword == password {
//                callback(UserProfile(id: username, displayName: username, provider: "HTTPBasic"))
//            } else {
//                callback(nil)
//            }
//        })
//        credentials.register(plugin: basicCredentials)
//
//        app.router.all("/entries", middleware: credentials)
//    }
}
