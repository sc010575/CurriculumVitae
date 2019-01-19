import Foundation
import GCDWebServer

class MockServer {
    var server = GCDWebServer()
    
    func start() {
        do {
            try server.start(options: [
                GCDWebServerOption_BindToLocalhost: true,
                GCDWebServerOption_Port: 8088,
                GCDWebServerOption_AutomaticallySuspendInBackground: false,
                ])
        } catch let exception {
            print(exception.localizedDescription)
        }
    }
    
    func stop() {
        if server.isRunning {
            server.stop()
        }
        
        server.removeAllHandlers()
    }
    
    @discardableResult
    func respondToGists(fixture: String = "gistResponse", statusCode: Int = 200)  -> MockServer {
        let responseData = dataFromFixture(fixture)
        
        addResponse(method: "GET", path: "/gists/feb733f8c6d6c38b9db4208fb7791567", responseData: responseData!, statusCode: statusCode)
        
        return self
    }
    
    @discardableResult
    func respondToGistsError(fixture: String = "gistErrorResponse", statusCode: Int = 404)  -> MockServer {
        let responseData = dataFromFixture(fixture)
        
        addResponse(method: "GET", path: "/gists/feb733f8c6d6c38b9db4208fb7791567", responseData: responseData!, statusCode: statusCode)

        return self
    }
    
    @discardableResult
    func respondToGistFile(fixture: String = "curriculumvitae", statusCode: Int = 200)  -> MockServer {
        let responseData = dataFromFixture(fixture)
        
        addResponse(method: "GET", path: "/sc010575/feb733f8c6d6c38b9db4208fb7791567", responseData: responseData!, statusCode: statusCode)
        
        return self
    }

}


private extension MockServer {
    
    func addResponse(method: String = "GET", path: String = "/", responseData: Data, statusCode: Int = 200) {
        server.addHandler(forMethod: method, path: path, request: GCDWebServerRequest.self) { request in
            print(request.url.absoluteString)
            let response = GCDWebServerDataResponse(data: responseData, contentType: "application/json")
            response.statusCode = statusCode
            return response
        }
    }
    
    func dataFromFixture(_ fixture: String) -> Data? {
        guard let responseData: Data = Fixtures.getJSONData(jsonPath: fixture) else {
            print("INVALID FIXTURE: \(fixture)")
            return nil
        }
        
        return responseData
    }
}
