//
//  DatabaseManager.swift
//  FreeMessenger
//
//  Created by Krishna Chaitanya D on 26/08/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}


//MARK: ACCOUNT MANAGEMENT

extension DatabaseManager{
    
    
    public func userExists(with email:String, completion: @escaping ((Bool) -> Void)){
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        database.child(safeEmail).observeSingleEvent(of: .value) { snapShot in
            
            guard snapShot.value as? String != nil else {
                
                completion(false)
                
                return
            }
            
            completion(true)
        }
        
        
    }
    
    /// Inserts new user to the Database
    public func insertUser(with user: ChatAppUser){
        
        database.child(user.safeEmail).setValue([
            "first_name":user.firstName,
            "last_name":user.lastName
            
        ])
        
    }

    
}

struct ChatAppUser {
    let firstName:String
    let lastName:String
    let emailAddress:String
    
    var safeEmail:String{
        
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        return safeEmail
    }
  //  let profilePictureUrl:String
}
