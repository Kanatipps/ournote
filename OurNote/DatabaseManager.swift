//
//  DatabaseManager.swift
//  OurNote
//
//  Created by Kana thip on 5/12/2564 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseManager {
    
    private let db = Firestore.firestore()
    private let auth = Auth.auth()
    static let shared = DatabaseManager()
    
    func signUpUser(email: String, password: String,fName: String, lName: String, completion: @escaping(Result<userModel,Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { [weak self] (authresult,error) in
            guard let strongSelf = self else {return}
            if let error = error {
                let authError = error as NSError
                print("autherror",authError)
                completion(.failure(authError))
                
            }
            else {
                var response = userModel()
                print("authresult",authresult?.user.uid)
                let userid = authresult?.user.uid ?? ""
                
                strongSelf.db.collection("users").document(userid).setData([
                    "firstname" : fName,
                    "lastname" : lName,
                    "email" : email,
                    "password" : password,
                    "uid" : authresult!.user.uid
                ]){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                        let dbError = err as NSError
                        completion(.failure(dbError))
                    }
                    else {
                        print("Document successfully written!")
                        response.fName = fName
                        response.lName = lName
                        response.email = email
                        response.password = password
                        completion(.success(response))
                    }
                }
            }
        }
    }
    
    func signInUser(email: String, password: String, completion:@escaping(Result<userModel,Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { [weak self] (authresult,error) in
            guard let strongSelf = self else {return}
            if let error = error {
                let authError = error as NSError
                print("authError",authError) //รอเพิ่มalertเมื่อสร้างไม่ได้เช่นรหัสไม่ถึง6ตัว หรือ เมลซ้ำ เป็นต้น
                completion(.failure(authError))
            }
            else {
                var response = userModel()
                print("authresult",authresult?.user.uid)
                let userid = authresult?.user.uid ?? ""
                let docRef = strongSelf.db.collection("users").document(userid)
                docRef.getDocument{ (document,err) in
                    if let err = err {
                        print("Error writing document: \(err)")
                        let dbError = err as NSError
                        completion(.failure(dbError))
                    }
                    else {
                        print("Document successfully written!")
                        let data = document?.data()
                        response.email = email
                        response.fName = data!["firstname"] as! String
                        response.lName = data!["lastname"] as! String
                        response.password = password
                        completion(.success(response))
                    }
                }
            }
        }
    }
    
    public func randomString() -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((1...6).map{ _ in letters.randomElement()! })
    }

    public func createClass(class_name:String,completion:@escaping(Result<classModel,Error>) -> Void) {
            var ref: DocumentReference? = nil
            var response = classModel()
            let invitecode = randomString()
            ref = db.collection("class").addDocument(data: [
                "classID" : "",
                "classCode" : invitecode,
                "className" : class_name,
                "classMember" : [],
                "classNoteID" : [],

            ]) { err in
                if let err = err {
                    completion(.failure(err))
                } else {
                    response.classCode = invitecode
                    response.className = class_name
                    response.classMember = []
                    completion(.success(response))
                }
            }
        }
    
    func updateClassID(){
        db.collection("class").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let Ref = self.db.collection("class").document(document.documentID)

                    Ref.updateData([
                        "classID": document.documentID
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                }
            }
        }
    }
    
}
