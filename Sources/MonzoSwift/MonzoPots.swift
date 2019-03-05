//
//  MonzoBalance.swift
//  MonzoSwift
//
//  Created by Asa Bowes on 04/03/2019.
//  Copyright © 2019 Podycust. All rights reserved.
//

import Foundation

public enum Currency: String, Decodable {
    case gbp = "GBP"
    case none = ""
    //...
}


public struct MonzoPots: Decodable {
    private enum CodingKeys: String, CodingKey {
        case balance = "balance"
        case id = "id"
        case style = "style"
        case currency = "currency"
        case deleted = "deleted"
        case updated = "updated"
        case created = "created"
        case Name = "name"
    }
/*"id": "pot_0000778xxfgh4iu8z83nWb",
 "name": "Savings",
 "style": "beach_ball",
 "balance": 133700,
 "currency": "GBP",
 "created": "2017-11-09T12:30:53.695Z",
 "updated": "2017-11-09T12:30:53.695Z",
 "deleted": false */
    let balance: Int
    let Name: String
    let currency: Currency
    let created: String
    let updated: String
    let deleted: false
    let style: String
    let id: String
}
