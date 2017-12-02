//
//  ServiceManager.swift
//  uHotel
//
//  Created by HeoConUnIn on 3/30/17.
//  Copyright © 2017 HoangSon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ServiceManager {
    public static let shared: ServiceManager = {
        return ServiceManager()
    }()
    
    
    
    
    
    
    // MARK: - USER
    

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - password: <#password description#>
    ///   - username: <#username description#>
    ///   - _completion: <#_completion description#>
    func loginUser(byPassword password: String?, byUsername username: String?, _completion:@escaping(_ code: CodeResponse, _ dataResponse: UserObj?) -> Void, _failed:@escaping(_ message: String?) -> Void) {
        
        let url = urlAPI + "dangnhap"
        let parameters: Parameters = [
            "user": username!,
            "pass": password!
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any] {
                    let feature = Mapper<UserMapper>().map(JSONObject: data)
                   
                    feature?.error = Int(String(describing: data["error"]!))
                    
                    if (feature?.error)! > 0 {
                        _failed(feature?.reason!)
                    } else {
                        _completion(.CODE_SUCCESS, feature!.detail)
                    }
                }
            case .failure( _):
                 _failed("")
            }
        }
    }

    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - userObj: <#userObj description#>
    ///   - _completion: <#_completion description#>
    func logoutUser(byUserObj userObj: UserObj, _completion:@escaping(_ code: CodeResponse, _ dataResponse: UserObj?) -> Void) {
        
        let url = urlAPI + "dangxuat"
        let parameters: Parameters = [
            "auth_code": userObj.auth_code!,
            "iduser": userObj.id!
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any] {
                    let feature = Mapper<UserMapper>().map(JSONObject: data)
                    
                    _completion(.CODE_SUCCESS, feature!.detail)
                }
            case .failure( _):
                _completion(.CODE_FAILURE, nil)
            }
        }
    }

    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - password: <#password description#>
    ///   - username: <#username description#>
    ///   - email: <#email description#>
    ///   - _completion: <#_completion description#>
    func registerUser(byPassword password: String?, byUsername username: String?, byEmail email: String?, _completion:@escaping(_ code: CodeResponse, _ dataResponse: UserObj?) -> Void, _failed:@escaping(_ message: String?) -> Void) {
        
        let url = urlAPI + "dangkyuser"
        let parameters: Parameters = [
            "user": username!,
            "pass": password!,
            "email": email!
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any] {
                    
                    let feature = Mapper<UserMapper>().map(JSONObject: data)
                    feature?.error = Int(String(describing: data["error"]!))
                    if feature!.error > 0 {
                        _failed(feature?.reason!)
                    } else {
                        _completion(.CODE_SUCCESS, nil)
                    }
                }
            case .failure( _):
                _failed("Email đã tồn tại")
            }
        }
    }
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - newPassword: <#newPassword description#>
    ///   - oldPassword: <#oldPassword description#>
    ///   - userObj: <#userObj description#>
    ///   - _completion: <#_completion description#>
    func changePassword(byNewPassword newPassword: String?, byOldPassword oldPassword: String?, byUserObj userObj: UserObj, _completion:@escaping(_ code: CodeResponse, _ dataResponse: String?) -> Void) {
        
        let url = urlAPI + "edituser"
        let parameters: Parameters = [
            "auth_code" : userObj.auth_code!,
            "username" : userObj.username!,
            "iduser" : userObj.id!,
            "old" : oldPassword!,
            "new" : newPassword!
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any] {
                    let feature = Mapper<UserMapper>().map(JSONObject: data)
                    if feature?.error == 1 {
                        _completion(.CODE_FAILURE, feature?.reason)
                    } else {
                        _completion(.CODE_SUCCESS, feature?.reason)
                    }
                }
            case .failure( _):
                _completion(.CODE_FAILURE, nil)
            }
        }
    }
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - userObj: <#userObj description#>
    ///   - _completion: <#_completion description#>
    func changeInfo(byUserObj userObj: UserObj, _completion:@escaping(_ code: CodeResponse, _ dataResponse: UserObj?) -> Void) {
        
        let url = urlAPI + "edituser"
        let parameters: Parameters = [
            "auth_code" : userObj.auth_code!,
            "username" : userObj.username!,
            "iduser" : userObj.id!,
            "email" : userObj.email!,
            "phone" : userObj.phone!,
            "last_name" : userObj.lastName!,
            "first_name" : userObj.firstName!
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any] {
                    let feature = Mapper<UserMapper>().map(JSONObject: data)
                    
                    _completion(.CODE_SUCCESS, feature!.detail)
                }
            case .failure( _):
                _completion(.CODE_FAILURE, nil)
            }
        }
    }
    
//MARK: - StoreNumber
    
    /// <#Description#>
    ///
    /// - Parameter _completion: <#_completion description#>
    func typeSim( _completion:@escaping(_ code: CodeResponse, _ dataResponse: [TypeSimObj]?) -> Void) {
        let url = urlAPI + "dangsim"
        Alamofire.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any] {
                    let feature = Mapper<TypeSimMapper>().map(JSONObject: data)
                    
                    _completion(.CODE_SUCCESS, feature!.detail)
                }
            case .failure( _):
                _completion(.CODE_FAILURE, nil)
            }
        }
    }
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - search: <#search description#>
    ///   - store: <#store description#>
    ///   - firstNumber: <#firstNumber description#>
    ///   - typeNumber: <#typeNumber description#>
    ///   - _completion: <#_completion description#>
    func searchSim(bySearch search: String?, byPage page: Int, byStore store: String?, byFirstNumber firstNumber: String?, byTypeNumber typeNumber: String?, _completion:@escaping(_ code: CodeResponse, _ dataResponse: [SimObj]?, _ nextLink: String?) -> Void) {
        let url = urlAPI + "timsim"
        let parameters: Parameters = [
            "dau" : firstNumber!,
            "kho" : store!,
            "dang" : typeNumber!,
            "search" : search!,
            "page" : page
        ]
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any] {
                    let feature = Mapper<SimMapper>().map(JSONObject: data)
                    
                    _completion(.CODE_SUCCESS, feature!.detail, feature?.nextLink)
                }
            case .failure( _):
                _completion(.CODE_FAILURE, nil, "")
            }
        }
    }
    
    
    /// <#Description#>
    ///
    /// - Parameter userObj: <#userObj description#>
    /// - Returns: <#return value description#>
    func captcha(byUserObj userObj: UserObj) -> String {
        return urlAPI + "captcha?auth_code=\(userObj.auth_code!)&iduser=\(userObj.id!)"
    }
    
    
    func category(byType type:CategoryType, _completion:@escaping(_ code: CodeResponse, _ dataResponse: [CategoryObj]?) -> Void) {
        let url = urlAPI + "theloai/\(type.rawValue)"
        
        Alamofire.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any] {
                    let feature = Mapper<CategoryMapper>().map(JSONObject: data)
                    
                    _completion(.CODE_SUCCESS, feature!.detail)
                }
            case .failure( _):
                _completion(.CODE_FAILURE, nil)
            }
        }
    }
    
    
//    MARK: - CONG NO
    func listCongNo(_completion:@escaping(_ code: CodeResponse, _ dataResponse: [CongNoObj]?) -> Void, _failed:@escaping(_ message: String?) -> Void) {
        
        let url = urlAPI + "congno"
        let parameters: Parameters = [
            "auth_code" : UserObj.currentUserProfile.auth_code!,
            "iduser" : UserObj.currentUserProfile.id!
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any] {
                    let feature = Mapper<CongNoMapper>().map(JSONObject: data)
                    
                    _completion(.CODE_SUCCESS, feature?.detail)
                }
            case .failure( _):
                _completion(.CODE_FAILURE, nil)
            }
        }
    }
    
//    MARK: - CHECK PHONE NUMBER
    func checkNumberPhone(byString stringSearch: String, _completion:@escaping(_ code: CodeResponse, _ dataResponse: String) -> Void) {
        
        let url = urlAPI + "sendchecksdt"
        let parameters: Parameters = [
            "auth_code" : UserObj.currentUserProfile.auth_code!,
            "iduser" : UserObj.currentUserProfile.id!,
            "sdt" : stringSearch
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value as? [String:Any] {
                    let feature = Mapper<CheckPhoneMapper>().map(JSONObject: data)
                    
                    _completion(.CODE_SUCCESS, (feature?.reason)!)
                }
            case .failure( _):
                _completion(.CODE_FAILURE, "")
            }
        }
    }
    
    //    MARK: - Upload image
    func uploadImge(bytype: UploadImageType, simObj: SimObj, cateObj: CategoryObj, listImage: [PostingImage], _completion:@escaping(_ code: CodeResponse, _ dataResponse: String) -> Void) {
        
        var url = ""
        let parameters: Parameters = [
//            "auth_code" : "UserObj.currentUserProfile.auth_code!",
//            "iduser" : "UserObj.currentUserProfile.id!",
            "auth_code" : "78c536d0bb4891dd877f059707f1d557",
            "iduser" : "2",
            "sdt" : simObj.name!,
            "idloai" : cateObj.idloai!
        ]
        
        if bytype == UploadImageType.ImageShopCard || bytype == UploadImageType.ImageTraTruoc {
            url = urlAPI + "upanh/" + "tratruoc"
            
        } else if bytype == UploadImageType.ImageTraSauCongTy {
            url = urlAPI + "upanh/" + "trasaudoanhnghiep"
            
        } else if bytype == UploadImageType.ImageTraSauCaNhan {
            url = urlAPI + "upanh/" + "trasaucanhan"
            
        }

        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
            for image in listImage {
                if let data = image.data {
                    multipartFormData.append(data, withName: image.imageKey!, mimeType: "image/jpeg")
                }
            }
        }, to: url, headers: headers)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                })
                
                upload.responseJSON { response in
                    print(response.result)
                    _completion(.CODE_SUCCESS, "")
                }
                
            case .failure( _):
                _completion(.CODE_FAILURE, "")
                break
                //print encodingError.description
            }
        }
        
        
//        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
//            switch response.result {
//            case .success:
//                if let data = response.result.value as? [String:Any] {
//                    let feature = Mapper<CheckPhoneMapper>().map(JSONObject: data)
//
//                    _completion(.CODE_SUCCESS, (feature?.reason)!)
//                }
//            case .failure( _):
//                _completion(.CODE_FAILURE, "")
//            }
//        }
    }
    
}
