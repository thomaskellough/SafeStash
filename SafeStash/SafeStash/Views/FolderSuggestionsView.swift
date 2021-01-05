////
////  FolderSuggestionsView.swift
////  SafeStash
////
////  Created by Thomas Kellough on 12/22/20.
////
//
//import SwiftUI
//
//struct FolderSuggestionsView: View {
//    @ObservedObject var newAccount: NewAccount
//    var accounts: FetchRequest<Account>
//    var suggestions: [String] = ["one", "two"]
//    
//    var body: some View {
//        HStack {
//            if accounts.wrappedValue.count > 0 {
//                List(accounts.wrappedValue, id: \.self) { account in
//                    
//                    Text(account.unwrappedFolder)
//                        .onTapGesture {
//                            newAccount.folder = account.unwrappedFolder
//                        }
//                }
//            }
//            
//            if suggestions.count > 0 {
//                ForEach(0..<suggestions.count, id: \.self) { index in
//                    Text(suggestions[index])
//                        .onTapGesture {
//                            newAccount.folder = suggestions[index]
//                        }
//                }
//            }
//        }
//        
////        if accounts.wrappedValue.count > 0 {
////            List(suggestions, id: \.self) { suggestion in
////                Text(suggestion)
////                    .onTapGesture {
////                        newAccount.folder = suggestion
////                    }
////            }
////        }
//    }
//    
//    init(newAccount: NewAccount, filter: String) {
//        self.newAccount = newAccount
//        print("Filter is: \(filter)")
//        accounts = FetchRequest<Account>(entity: Account.entity(), sortDescriptors: [], predicate: NSPredicate(format: "folder CONTAINS %@", filter))
//        
//        let fetch = FetchRequest<Account>(entity: Account.entity(), sortDescriptors: [])
//        print("Fetch count: \(fetch.wrappedValue.count)")
//        
//        print("Accounts count: \(accounts.wrappedValue.count)")
//        for account in accounts.wrappedValue {
//            self.suggestions.append(account.unwrappedFolder)
//        }
////        self.suggestions = accounts.wrappedValue.compactMap { $0.unwrappedFolder }
//        print("Suggestions 2: \(self.suggestions)")
//        self.suggestions = Array(Set(suggestions))
//        print("Suggestions 3: \(self.suggestions)")
//    }
//}
//
//struct FolderSuggestionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderSuggestionsView(newAccount: NewAccount(), filter: "")
//    }
//}
