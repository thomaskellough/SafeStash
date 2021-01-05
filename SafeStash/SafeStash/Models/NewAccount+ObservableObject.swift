//
//  NewAccount+ObservableObject.swift
//  SafeStash
//
//  Created by Thomas Kellough on 12/22/20.
//

import SwiftUI

class NewAccount: ObservableObject {
    @Published var folder = ""
    @Published var name = ""
    @Published var username = ""
    @Published var password = ""
    @Published var email = ""
    @Published var notes = ""
    @Published var pin = ""
}
