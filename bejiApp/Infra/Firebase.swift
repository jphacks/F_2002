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
//汚いので書き直す

class FirebaseAction: NSObject {
    let storage = Storage.storage()
    var databaseRef: DatabaseReference!
    var userID: String!
    func fileupload(dataUrlStr: String?) -> String {
        let storageRef = storage.reference(forURL: "path/to/project/url")
        let uuid = UUID()
        let imageRef = storageRef.child("images").child(userID).child("\(uuid).jpg")
        guard let dataUrlStr = dataUrlStr else {
            return ""
        }
        let dataUrl = URL(string: dataUrlStr)!
        var downloadUrl = ""
        let uploadTask = imageRef.putFile(from: dataUrl, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else { return }
            let size = metadata.size
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else { return }
                downloadUrl = downloadURL.absoluteString
            }
        }
        return downloadUrl
    }
    
    //汚すぎるので後でちゃんと書く
    func getIotData(viewdata: CommonData,completion: @escaping(IotData) -> (Void)){
        guard let uid = viewdata.uid else { fatalError() }
       
        databaseRef.child("device_data").child("4fafc201-1fb5-459e-8fcc-c5c9c331914b").observeSingleEvent(of: .value, with: { (snapshot) in
            let dateFormatter = DateFormatter()
            let dt = Date()
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
            print(dateFormatter.string(from: dt))
            let value = snapshot.value as? NSDictionary
            guard let v = value else { return }
//            do {
//                    // Dict -> JSON
//                let jsonData = try JSONSerialization.data(withJSONObject: v, options: []) //(*)options??
//
//                let json = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//                Log.printLog(type: "jdon", logData: json)
//                let user = try! JSONDecoder().decode(IotData.self, from: jsonData)
//
//                Log.printLog(type: "いえーーい", logData: user)
//                Log.printLog(type: "jdondata", logData: jsonData)
//
//                } catch {
//                    print("Error!: \(error)")
//                }

            let date =  dateFormatter.string(from: dt)
            let create = value?["createdAt"] as? String ?? ""
            let cultivationId = value?["cultivationId"] as? String ?? ""
            let humidity = value?["humidity"] as? NSDictionary
            let illuminance = value?["illuminance"] as? NSDictionary
            let pressure = value?["pressure"] as? NSDictionary
            let solidmoisture = value?["solid_moisture"] as? NSDictionary
            let temperature = value?["temperature"] as? NSDictionary
            let humidityData: IotData.Status = .init(status: humidity?["status"] as? String ?? "", value: humidity?["value"] as? Int ?? 0)
            let illuminancedata: IotData.Status = .init(status: illuminance?["status"] as? String ?? "", value: illuminance?["value"] as? Int ?? 0)
            let pressuredata: IotData.Status = .init(status: pressure?["status"] as? String ?? "", value: pressure?["value"] as? Int ?? 0)
            let solidmoistureData: IotData.Status =  .init(status: solidmoisture?["status"] as? String ?? "", value: solidmoisture?["value"] as? Int ?? 0)
            let temperaturedata: IotData.Status = .init(status: temperature?["status"] as? String ?? "", value: temperature?["value"] as? Int ?? 0)
            var iotData: IotData = .init(created: create, cultivationld: cultivationId,
                                         humidity: humidityData ,
                                         illuminance: illuminancedata,
                                         pressure: pressuredata,
                                         solidMoisture: solidmoistureData,
                                         temperture: temperaturedata,
                                         beji: viewdata.type
            )
            
            completion(iotData)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func getChatData(viewdata: CommonData,completion: @escaping([ChatData]) -> (Void)){
        guard let uid = viewdata.uid else { fatalError() }
        databaseRef.child("chat_room").child("users/\(uid)/username/\(viewdata.type.chatName)/").observeSingleEvent(of: .value, with: { (snapshot) in
            var chatData: [ChatData] = []
            for item in snapshot.children {
                let child = item as! DataSnapshot
                let dic = child.value as! NSDictionary
                chatData.append(ChatData(title: dic["name"] as? String ?? "" , message: dic["message"] as? String ?? ""))
            }
            let value = snapshot.value as? NSDictionary
            let message = value?["message"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            chatData.append(.init(title: message, message: name))
            
            completion(chatData)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func postChatData(userMessage: String,viewdata: CommonData, completion: @escaping(ChatData) -> (Void)) {
        guard let uid = viewdata.uid else { fatalError() }
        let data = ["name": "me", "message": userMessage]
        databaseRef.child("chat_room").child("users/\(uid)/username/\(viewdata.type.chatName)/").childByAutoId().setValue(data)
        let chatData: ChatData = .init(title: data["name"] as? String ?? "", message: data["message"] as? String ?? "")
        completion(chatData)
    }
    
}
