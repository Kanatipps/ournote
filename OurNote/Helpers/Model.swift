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
    var noteID : [String]?

}
struct noteModel : Codable {
    var noteTitle : String?
    var noteDetail : String?
    var noteID : String?
    var usersMemer : [String]?
}
