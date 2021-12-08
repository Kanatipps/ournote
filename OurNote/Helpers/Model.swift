//
//  Model.swift
//  OurNote
//
//  Created by Kana thip on 5/12/2564 BE.
//

import Foundation

struct userModel : Codable {
    var email : String?
    var password : String?
    var fName : String?
    var lName : String?
    var uid : String?
}
struct classModel : Codable {
    var className : String?
    var classID : String?
    var classCode : String?
    var classMember : [String]?
    var noteID : [String]?
}
