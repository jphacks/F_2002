//
//  FirebaseAction.swift
//  JPHacksSample
//
//  Created by Gyuho on 2020/11/02.
//

import Foundation
import UIKit
import Firebase

class FirebaseAction: NSObject {
    
    let storage = Storage.storage();
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
        
        // Upload the file to the path "images/image.jpg"
        let uploadTask = imageRef.putFile(from: dataUrl, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
            // Uh-oh, an error occurred!
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
}
