//
//  Ticket.swift
//  MinhaCativa
//
//  Created by Luís Santos on 21/09/23.
//

import Foundation

struct Ticket: Identifiable {
    var id = UUID()
    var name: String
    var phone: String
    var sector: Ticket.Sector
    var price: String
    
    enum Sector: String, CaseIterable {
        case Oeste_Superior
        case Oeste_Inferior
        case Camarote
    }
}
