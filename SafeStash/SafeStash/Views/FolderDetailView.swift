//
//  GroupDetailView.swift
//  SafeStash
//
//  Created by Thomas Kellough on 12/20/20.
//

import SwiftUI

struct FolderDetailView: View {
    var accounts: FetchRequest<Account>
    var accountName: String
    
    var body: some View {
        List(accounts.wrappedValue, id: \.self) { account in
            NavigationLink(destination: AccountDetailView(account: account)) {
                Text("\(account.unwrappedName)")
            }
        }
        .navigationTitle(accountName)
    }
    
    init(filter: String) {
        self.accountName = filter
        accounts = FetchRequest<Account>(entity: Account.entity(), sortDescriptors: [], predicate: NSPredicate(format: "folder == %@", filter))
    }
}

struct GroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FolderDetailView(filter: "Group : 0").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
