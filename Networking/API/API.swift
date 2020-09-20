//
//  API.swift
//  Networking
//
//  Created by Ahmed on 9/20/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation
import Alamofire
import KRProgressHUD

class API: NSObject{

    class func POST(url: String, parameters: [String:Any]?, headers: [String:Any]?, completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]) -> Void) {
        KRProgressHUD.show()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: (headers as? HTTPHeaders)).responseJSON { /*[weak self]*/(response) in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(false, [:])
                KRProgressHUD.dismiss()
            case .success(let value):
                print(value)
                completion(true, value as! [String: AnyObject])
                KRProgressHUD.dismiss()
            }
        }
    }
    
    class func POSTAndBackArray(url: String, parameters: [String:Any], headers: [String:Any]?, completion: @escaping (_ succeeded: Bool, _ result: [[String: AnyObject]]) -> Void) {
        KRProgressHUD.show()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: (headers as? HTTPHeaders)).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(false, [[:]])
                KRProgressHUD.dismiss()
            case .success(let value):
                print(value)
                completion(true, value as? [[String: AnyObject]] ?? [])
                KRProgressHUD.dismiss()
            }
        }
    }
    
    class func POSTWithNoReturn(url: String, parameters: [String:Any], headers: [String:Any]?, completion: @escaping (_ succeeded: Bool, _ result: Any) -> Void) {
        KRProgressHUD.show()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: (headers as? HTTPHeaders)).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
                completion(false, [:])
                KRProgressHUD.dismiss()
            case .success(let value):
                print(value)
                completion(true, value )
                KRProgressHUD.dismiss()
            }
        }
    }
    
    class func GET(url: String, completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]) -> Void) {
        KRProgressHUD.show()
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respone) in
            switch respone.result {
            case .failure(let error):
                print(error)
                completion(false, [:])
                KRProgressHUD.dismiss()
            case .success(let value):
                print(value)
                completion(true, value as! [String: AnyObject])
                KRProgressHUD.dismiss()
            }
        }
    }
    
    class func GETWithIndicator(url: String,indicator:Bool, completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]) -> Void) {
        if indicator{
        KRProgressHUD.show()
        }
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respone) in
            switch respone.result {
            case .failure(let error):
                print(error)
                completion(false, [:])
                KRProgressHUD.dismiss()
            case .success(let value):
                print(value)
                completion(true, value as! [String: AnyObject])
                KRProgressHUD.dismiss()
            }
        }
    }
    
    class func GETwithHeader(url: String, header:[String:Any]? ,completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]) -> Void) {
        KRProgressHUD.show()
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header as? HTTPHeaders).responseJSON { (respone) in
            switch respone.result {
            case .failure(let error):
                print(error)
                completion(false, [:])
                KRProgressHUD.dismiss()
            case .success(let value):
                print(value)
                completion(true, value as! [String: AnyObject])
                KRProgressHUD.dismiss()
            }
        }
    }
    
    class func POSTImage(url: String, Images: [UIImage]?,Keys: [String]?,header:[String:Any]?, parameters:[String: Any]?, completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]) -> Void) {
        KRProgressHUD.show()
        AF.upload(multipartFormData: { (multipartFromData) in
            if parameters != nil{
            for (key, value) in parameters! {
                multipartFromData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            if Images != nil{
                for x in 0...(Images?.count)!-1 {
                    let data = Images![x].jpegData(compressionQuality: 0.5)
                multipartFromData.append(data!, withName: "file[\(x)]",fileName: "file[\(x)].jpg", mimeType: "image/jpg")
                
                }
            }
        }, to: url , method: .post, headers: header as? HTTPHeaders) .responseJSON { (response) in
            switch response.result {
                
            case .success(let value):
                print(value)
                completion(true,  value as! [String : AnyObject])
                KRProgressHUD.dismiss()
            case .failure(let error):
                print(error)
                completion(false, [:])
                KRProgressHUD.dismiss()
            }
            
        }
        
    }
    
        
    class func POSTImageProfile(url: String, Images: Data?,header:[String:Any]?, parameters:[String: Any]?, completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]) -> Void) {
        KRProgressHUD.show()
        AF.upload(multipartFormData: { (multipartFromData) in
            if parameters != nil{
                for (key, value) in parameters! {
                    multipartFromData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            if Images != nil{
                multipartFromData.append(Images!, withName: "my_file_upload[0]", fileName: "Image.jpg", mimeType: "image/jpg")
            }
        }, to: url , method: .post, headers: header as? HTTPHeaders) .responseJSON { (response) in
            switch response.result {
                
            case .success(let value):
                print(value)
                completion(true,  value as! [String : AnyObject])
                KRProgressHUD.dismiss()
            case .failure(let error):
                print(error)
                completion(false, [:])
                KRProgressHUD.dismiss()
            }
            
        }
    }
    
    class func POSTImageEdit(url: String, Images: [Data]?,Keys: [String]?,header:[String:Any]?, parameters:[String: Any]?, completion: @escaping (_ succeeded: Bool, _ result: [String: AnyObject]?) -> Void) {
        KRProgressHUD.show()
        AF.upload(multipartFormData: { (multipartFromData) in
            if parameters != nil{
                for (key, value) in parameters! {
                    multipartFromData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            if Images != nil{
                for (img ,key) in zip(Images!,Keys!){
                    multipartFromData.append(img, withName: key, fileName: "Image.jpg", mimeType: "image/jpg")
                }
            }
        }, to: url , method: .post, headers: header as? HTTPHeaders) .responseJSON { (response) in
            switch response.result {
                
            case .success(let value):
                print(value)
                completion(true,  value as! [String : AnyObject])
                KRProgressHUD.dismiss()
            case .failure(let error):
                print(error)
                completion(false, [:])
                KRProgressHUD.dismiss()
            }
            
        }
        
    }
    
}
