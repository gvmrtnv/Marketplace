//
//  AuthManager.swift
//  Influencer
//
//  Created by Gleb Martynov on 16.01.22.
//

import Foundation
import FirebaseAuth
import UIKit

public class AuthManager {
    static let shared = AuthManager()
    // MARK: - Public
    
    public func sendVerificationMessage() {
        PhoneAuthProvider.provider().verifyPhoneNumber("*49131313", uiDelegate: nil) { verificationID, error in
            guard error == nil else {return}
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        }
    }
    
    public func verifyNumber(with code: String, completion: @escaping (Bool)-> Void) {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {return}
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        Auth.auth().currentUser?.link(with: credential, completion: { _, error in
            if error == nil{
                completion(true)
            }
            else {
                completion(false)
            }
        })
    }
    
    public func registerNewUser(email: String, password: String, completion: @escaping (Bool)->Void) {
        /*
         - Check if username is available
         - Check if email is available
         */
        DatabaseManager.shared.canCreateNewUser(with: email) { canCreate in
            if canCreate {
                 //- Create account
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, let user = result?.user else {
                        completion(false)
                        return
                    }
                    //- Insert account to a database
                    DatabaseManager.shared.insertNewUser(with: email, userId: user.uid) { inserted in
                        if inserted {
                            user.sendEmailVerification { error in
                                guard error == nil else {
                                    completion (false)
                                    return
                                }
                                completion(true)
                                return
                            }
                            
                        }
                        else {
                            // Failed insert to database
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                // either username or email does not exist
                completion(false)
                return
                
            }
        }
    }
    
    public enum loginStatus {
        case success, failure, notVerified
    }
    
    public func loginUser(username: String?, email:String?, password: String, completion: @escaping (loginStatus)->Void) {
        if let email = email {
            // login with username
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard let user = authResult?.user, error == nil
                else {
                    completion(.failure)
                    return
                }
                if user.isEmailVerified{
                    completion(.success)
                }
                else {
                    completion(.notVerified)
                }
                
            }
        }
        else if let username = username {
            // username log in
            print(username)
        }
    }
    /// Attempt to log out firebase user
    public func logoutUser(completion: (Bool)-> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print(error)
            completion(false)
            return
        }
    }
    
}
