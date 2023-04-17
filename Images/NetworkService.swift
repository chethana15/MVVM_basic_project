import Foundation



func commonRequest(strURL:String, requestMethod: String, parameters: [String:Any]?,headerFied: [String:String]?,body: [String:Any]?, success:@escaping(_ result:Any)->Void, failure:@escaping(_ error:Any) -> Void){
    var components = URLComponents(string: strURL)!
    
    if let params = parameters {
        components.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: "\(value)")
        }
    }
    
    var request = URLRequest(url: components.url!)
    let jsonBody: [String: Any] = body ?? [String:Any]()
    let jsonBodyData = try? JSONSerialization.data(withJSONObject: jsonBody)
    if(requestMethod == "GET"){
        
    }else{
        request.httpBody = jsonBodyData
    }
    
    
    request.httpMethod = requestMethod
    request.allHTTPHeaderFields = headerFied
    let task = URLSession.shared.dataTask(with: request) {(data,response,error) in
        DispatchQueue.main.async(){
            
            if response != nil {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("statusCode:\(statusCode)")
                if let responseData = data,let responseBody = String(data:responseData,encoding: .utf8)
                {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse?.statusCode as Any)
                    print("data is \(responseData)")
                    print("Response body is" + responseBody)
                    if(responseBody == "Successfully deleted your account"){
                        success(responseBody)
                    }
                    
                    
                }
                if statusCode == 401 {
                    failure("Unauthorized")

                } else if error != nil {
                    print(error?.localizedDescription as Any)
                    failure(error?.localizedDescription as Any)
                } else {
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with:data!,options:.mutableContainers)
                        print(parsedData)
                        if(statusCode==200){
                            success(parsedData as Any)
                        }
                        
                    } catch {
                        print("error=\(error)")
                        failure(error)
                        return
                    }
                }
            } else {
                failure(error as Any)
            }
            
        }
    }
    task.resume()
}
