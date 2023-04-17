
import Foundation

class GetImagesViewModel {

    func fetchImageDetails(success:@escaping(_ result: ImagesResponse)->Void, failure:@escaping(_ error:Any) -> Void) {
        let url = constants.imagesDetailsURL

        commonRequest(strURL: url, requestMethod: "GET", parameters: nil, headerFied: nil, body: nil, success: { result in

            guard let jsonData = try? JSONSerialization.data(withJSONObject: result, options: .prettyPrinted) else {
                failure("Error converting response to JSON")
                return
            }

            guard let imagesResponse = try? JSONDecoder().decode(ImagesResponse.self, from: jsonData) else {
                failure("Error decoding response data")
                return
            }

            success(imagesResponse)

        }, failure: { error in
            failure(error)
        })
    }
}
