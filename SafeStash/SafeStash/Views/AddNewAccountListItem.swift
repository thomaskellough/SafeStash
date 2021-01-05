//
//  AddNewAccountListItem.swift
//  SafeStash
//
//  Created by Thomas Kellough on 12/22/20.
//

import SwiftUI

struct AddNewAccountListItem: View {
    @ObservedObject var newAccount: NewAccount
    @State private var accountNewValue = ""
    @State private var isShowingSuggestions = false
    @State private var value: String = ""
    let title: String
    let placeholder: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .frame(width: 100, alignment: .leading)
                    .font(.headline)
                    .border(width: 1, edges: [.trailing], color: Color.secondary)
                TextField(placeholder, text: $value)
                    .frame(alignment: .leading)
                    .padding(2)
                    .onChange(of: value) { newValue in
                        updateValue(newValue)
                    }
            }
        }
    }
    
    func updateValue(_ newValue: String) {
        switch self.title {
        case "Username":
            newAccount.username = newValue
        case "Name":
            newAccount.name = newValue
        case "Email":
            newAccount.email = newValue
        case "Pin":
            newAccount.pin = newValue
        case "Password":
            newAccount.password = newValue
        default:
            fatalError("Error: Could not find \(title)")
        }
    }
}

struct AddNewAccountListItem_Previews: PreviewProvider {
    static var previews: some View {
        AddNewAccountListItem(newAccount: NewAccount(), title: "Title", placeholder: "Placeholder")
    }
}
