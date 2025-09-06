//
//  AuthManager.swift
//  Chatterly
//
//  Created by assistant on 18/10/25.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AuthManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userEmail: String? = nil
    private var authStateHandle: AuthStateDidChangeListenerHandle?

    init() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.isLoggedIn = (user != nil)
                self?.userEmail = user?.email
            }
        }
    }

    deinit {
        if let handle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let e = error {
                    completion(.failure(e))
                    return
                }
                self.isLoggedIn = true
                self.userEmail = result?.user.email
                completion(.success(()))
            }
        }
    }

	func signUp(username: String ,email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let e = error {
                    completion(.failure(e))
                    return
                }
                // create a basic user document
                let db = Firestore.firestore()
                if let uid = result?.user.uid {
                    db.collection("users").document(uid).setData([
						"id": uid,
						"name": username,
                        "email": email,
                        "createdAt": FieldValue.serverTimestamp()
                    ], merge: true) { err in
                        if let err = err {
                            completion(.failure(err))
                        } else {
                            self.isLoggedIn = true
                            self.userEmail = email
                            completion(.success(()))
                        }
                    }
                } else {
                    self.isLoggedIn = true
                    self.userEmail = email
                    completion(.success(()))
                }
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.isLoggedIn = false
                self.userEmail = nil
            }
        } catch {
            print("Error signing out:", error)
        }
    }

    var currentUserId: String? {
        return Auth.auth().currentUser?.uid
    }
}


