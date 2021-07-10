//
//  ServiceLayer.swift
//  OrionVision
//
//  Created by Дмитрий Константинов on 10.07.2021.
//

import Foundation
import UIKit
import MapKit

protocol NetworkServiceProtocol {
        
    func getCamerasAPI(complit: @escaping (_ camerasJSON: [CameraRawJSON]) -> Void)
    func getImage(id: Int, complit: @escaping (_ picture: UIImage?) -> Void)
}

class NetworkService: NetworkServiceProtocol {

    func getCamerasAPI(complit: @escaping (_ camerasJSON: [CameraRawJSON]) -> Void) {
        
        let request = URLRequest(url: getURLAPI())
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let httpStatus = response as? HTTPURLResponse
            let code = httpStatus?.statusCode
                guard let data = data else { return }
                do {
                    let cameras = try JSONDecoder().decode([CameraRawJSON].self, from: data)
                    complit(cameras)
                } catch let error {
                    print(error)
                }
            print("statusCode: \(code ?? 999)")
        }.resume()
    }
    
    func getImage(id: Int, complit: @escaping (_ picture: UIImage?) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            let stringUrl = "https://orionnet.online/api/v2/preview_images/\(id)"
            let url = URL(string: stringUrl)!
            guard let imageData = try? Data(contentsOf: url) else {return}
                let image = UIImage(data: imageData)
                complit(image)
        }
    }
}

extension NetworkService {
    private func getURLAPI() -> URL{
        return URL(string: "https://orionnet.online/api/v1/cameras/public")!
    }
}
