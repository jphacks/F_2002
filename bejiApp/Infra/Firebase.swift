//
//  Firebase.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/05.
//

import Foundation

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseCore
import FirebaseStorage

//将来的にFirebaseで画像保存->判別する際に利用するファイル

class FirebaseAction: NSObject {

    let storage = Storage.storage()
    var databaseRef: DatabaseReference!
    var userID: String!

    func fileupload(dataUrlStr: String?) -> String {
        //保存するURLを指定
        let storageRef = storage.reference(forURL: "path/to/project/url")
        let uuid = UUID()
        //ディレクトリを指定
        let imageRef = storageRef.child("images").child(userID).child("\(uuid).jpg")

        guard let dataUrlStr = dataUrlStr else {
                return ""
            }

        let dataUrl = URL(string: dataUrlStr)!
        var downloadUrl = ""
        let uploadTask = imageRef.putFile(from: dataUrl, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
            return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                downloadUrl = downloadURL.absoluteString
            }
        }
        return downloadUrl
    }
    func uploadChatData(from: String, to: String, message: String? = nil, imageUrl: String? = nil){
        databaseRef.child("chat").childByAutoId().setValue(["from": from, "to": to, "message": message, "image_url": imageUrl])
    }
    func getIotData(viewdata: CommonData,completion: @escaping(IotModel) -> (Void)){
        
        guard let uid = viewdata.uid else { fatalError() }
        print("uid\(uid)")
        databaseRef.child("device_data").child("4fafc201-1fb5-459e-8fcc-c5c9c331914b").observeSingleEvent(of: .value, with: { (snapshot) in
            let dateFormatter = DateFormatter()
            let dt = Date()
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
            print(dateFormatter.string(from: dt))
            let value = snapshot.value as? NSDictionary
            let date =  dateFormatter.string(from: dt)
            let create = value?["createdAt"] as? String ?? ""
            let cultivationId = value?["cultivationId"] as? String ?? ""
            let humidity = value?["humidity"] as? NSDictionary
            let illuminance = value?["illuminance"] as? NSDictionary
            let pressure = value?["pressure"] as? NSDictionary
            let solidmoisture = value?["solid_moisture"] as? NSDictionary
            let temperature = value?["temperature"] as? NSDictionary
            let humidityData: IotModel.Status = .init(status: humidity?["status"] as? String ?? "", value: humidity?["value"] as? Int ?? 0)
            let illuminancedata: IotModel.Status = .init(status: illuminance?["status"] as? String ?? "", value: illuminance?["value"] as? Int ?? 0)
            let pressuredata: IotModel.Status = .init(status: pressure?["status"] as? String ?? "", value: pressure?["value"] as? Int ?? 0)
            let solidmoistureData: IotModel.Status =  .init(status: solidmoisture?["status"] as? String ?? "", value: solidmoisture?["value"] as? Int ?? 0)
            let temperaturedata: IotModel.Status = .init(status: temperature?["status"] as? String ?? "", value: temperature?["value"] as? Int ?? 0)
            var iotData: IotModel = .init(created: create, cultivationld: cultivationId,
                                          humidity: humidityData,
                                          illuminance: illuminancedata,
                                          pressure: pressuredata,
                                          solidMoisture: solidmoistureData,
                                          temperture: temperaturedata,
                                          beji: viewdata.type
            )
            print("firebasecheck\(iotData)")
            completion(iotData)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func getChatData(viewdata: CommonData,completion: @escaping([ChatDataModel]) -> (Void)){
        
        guard let uid = viewdata.uid else { fatalError() }
        print("uid\(uid)")
        databaseRef.child("chat_room").child("users/\(uid)/username/\(viewdata.type.chatName)/").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var chatData: [ChatDataModel] = []
            for item in snapshot.children {
                let child = item as! DataSnapshot
                let dic = child.value as! NSDictionary
                chatData.append(ChatDataModel(title: dic["name"] as? String ?? "" , message: dic["message"] as? String ?? ""))
            }
            let value = snapshot.value as? NSDictionary
            let message = value?["message"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            chatData.append(.init(title: message, message: name))
            completion(chatData)
            print("ch\(chatData)")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
