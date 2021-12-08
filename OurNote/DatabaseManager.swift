//
//  DatabaseManager.swift
//  OurNote
//
//  Created by Kana thip on 5/12/2564 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase

//hellokana
//Hello Ken

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
                        response.password = password
                        response.fName = data!["firstname"] as! String
                        response.lName = data!["lastname"] as! String
                        response.uid = data!["uid"] as! String
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

    public func createClass(class_name: String, completion:@escaping(Result<classModel,Error>) -> Void) {
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
    
    public func createNote(noteTitle: String, noteDtail:String, completion:@escaping(Result<classModel,Error>) -> Void) {
            var ref: DocumentReference? = nil
            var response = classModel()
            let invitecode = randomString()
            let IDnote = updateNoteID()
            ref = db.collection("class").addDocument(data: [
                "classID" : IDnote,
                "noteDetail" : noteDtail,
                "title" : noteTitle,
             
            ]) { err in
                if let err = err {
                    completion(.failure(err))
                } else {
                    completion(.success(response))
                }
            }
        }
    
    func updateNoteID(){
        db.collection("note").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let Ref = self.db.collection("note").document(document.documentID)

                    Ref.updateData([
                        "noteID": document.documentID
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
    
    
//    func checkJoinClass(invite:String,classdata:[classModel]) -> Bool {
//        
//            var check = false
//            var classselect = classModel()
//            for i in classdata {
//                if invite == i.classCode {
//                    check = true
//                    print("found")
//                    classselect = i
//                }
//            }
//            
//            if classselect.classMember != nil {
//                print("class=",classselect.classMember)
//                for k in classselect.classMember! {
//                    if checkUID() == k {
//                        print("user=",checkUID())
//                        print("k=",k)
//                        print("id found")
//                        check = false
//                    }
//                }
//            }
//            return check
//        }
//    
//    
//    //
//    
//    public func checkUID() -> String {
//            return UserDefaults.standard.string(forKey: "uid") ?? ""
//        }
//    
//    func getDocIDClassAttendance(invite:String,classdata:[classModel]) -> String {
//            var doc:String = ""
//            for i in classdata {
//                if invite == i.classCode{
//                    doc = i.classID!
//                }
//            }
//            return doc
//        }
//    
//    func addStudentList(invite:String,classdata:[classModel],id:String){
//            let Ref = self.db.collection("class").document(getDocIDClassAttendance(invite: invite, classdata: classdata))
//
//            Ref.updateData([
//                "studentList": FieldValue.arrayUnion([id]) ,
//            ]) { err in
//                if let err = err {
//                    print("Error updating document: \(err)")
//                } else {
//                    print("Document successfully updated")
//                }
//            }
//        }
//    //
    
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
    
//    func getClass() {
//            let db = Firestore.firestore()
//            db.collection("card").getDocuments() { [weak self] (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    var data = [classModel]()
//                    for document in querySnapshot!.documents {
//                        if let userid = Auth.auth().currentUser?.uid {
//                            if userid == document.data()["uid"] as! String {
//                                var obj = classModel()
//                                obj.uid = document.data()["uid"]! as! String
//                                obj.cardname = document.data()["cardname"]! as! String
//                                obj.point = document.data()["point"]! as! Int
//                                data.append(obj)
//                            }
//                        }
//                        self?.data = data
//                        self?.tableview.reloadData()
//    //                    print("\(document.documentID) => \(document.data())")
//                    }
//                }
//            }
//        }
    
    func logout() {
            do {
                try FirebaseAuth.Auth.auth().signOut()
                print("Log Out Success")
            }
            catch {
                print("An error occurred")
            }
        }
    
    public func checkUserID() -> String {
            return UserDefaults.standard.string(forKey: "uid") ?? ""
        }
}
