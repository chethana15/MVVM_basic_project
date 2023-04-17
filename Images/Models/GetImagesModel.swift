

import Foundation

//MARK: - Model for response
struct ImagesResponse: Codable {
    let statusCode: Int?
    let ImageDetailsDictionary: [ImageDetails]?
    
    private enum dataCodingkey:String, CodingKey{
        case statusCode = "status"
        case ImageDetailsDictionary = "data"
    }
    
    init(from decoder: Decoder) throws {
        let info = try decoder.container(keyedBy: dataCodingkey.self)
        statusCode = try info.decodeIfPresent(Int.self, forKey: .statusCode)
        ImageDetailsDictionary = try info.decodeIfPresent([ImageDetails].self, forKey: .ImageDetailsDictionary)
    }
}

//MARK: - Model for ImageDetailsDictionary
struct ImageDetails: Codable {
    var title = String()
    var image = String()
    
    private enum dataCodingkey:String, CodingKey{
        case title = "title"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let info = try decoder.container(keyedBy: dataCodingkey.self)
        title = try info.decodeIfPresent(String.self, forKey: .title) ?? ""
        image = try info.decodeIfPresent(String.self, forKey: .image) ?? ""
    }
    
}
