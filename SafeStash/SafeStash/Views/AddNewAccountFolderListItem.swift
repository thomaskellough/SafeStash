//
//  AddNewAccountFolderListItem.swift
//  SafeStash
//
//  Created by Thomas Kellough on 12/22/20.
//

import SwiftUI

struct AddNewAccountFolderListItem: View {
    @ObservedObject var newAccount: NewAccount
    @State private var accountNewValue = ""
    @State private var isShowingSuggestions = false
    @State private var value: String = ""
    @State private var sugggestions: [String] = []
    
    @FetchRequest(entity: Account.entity(), sortDescriptors: []) var accounts: FetchedResults<Account>
    
    @State private var filterString = ""

    let title: String
    let placeholder: String
    
    var body: some View {
        let binding = Binding(
            get: { self.newAccount.folder },
            set: { self.value = $0 }
        )
//        let suggestionsBinding = Binding (
//            get: {
//                var all = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
//                var filtered =  all.filter { $0.contains(filterString) }
//                self.filtered = filtered
//            },
//            set: { self.sugggestions = ["One", "Two", "Three", "Four", "Five", "Six", "Seven"] }
//        )
        
        VStack {
            HStack {
                Text(title)
                    .frame(width: 100, alignment: .leading)
                    .font(.headline)
                    .border(width: 1, edges: [.trailing], color: Color.secondary)
                TextField(placeholder, text: binding)
                    .frame(alignment: .leading)
                    .padding(2)
                    .onChange(of: value) { newValue in
                        newAccount.folder = newValue
                        self.filterString = newValue
                        self.filterFolders()
//                        self.showSuggestions(newValue: newValue)
                    }
            }
            isShowingSuggestions
            ? List(sugggestions, id: \.self) { suggestion in
                Text(suggestion)
                    .onTapGesture {
                        self.value = suggestion
                        self.isShowingSuggestions = false
                    }
            }
            : nil
        }
        .onAppear(perform: filterFolders)
    }
    
    func filterFolders() {
        var all: [String] = []
        for account in accounts {
            all.append(account.unwrappedFolder)
        }
        self.sugggestions = all.filter { $0.contains(filterString) }
        self.sugggestions = Array(Set(sugggestions))
        self.isShowingSuggestions = self.sugggestions.count > 0 ? true : false
    }
    
//    func showSuggestions(newValue: String) {
//        self.accountNewValue = newValue
//        isShowingSuggestions = true
//    }
}

struct AddNewAccountFolderListItem_Previews: PreviewProvider {
    static var previews: some View {
        AddNewAccountFolderListItem(newAccount: NewAccount(), title: "Folder", placeholder: "Placeholder Text")
    }
}
