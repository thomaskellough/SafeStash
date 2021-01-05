//
//  GroupsListView.swift
//  SafeStash
//
//  Created by Thomas Kellough on 12/19/20.
//

import SwiftUI

struct FolderListView: View {
    @FetchRequest(entity: Account.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Account.name, ascending: true)
    ]) var accounts: FetchedResults<Account>
    
    var body: some View {
        List(accounts) { account in
            NavigationLink(destination: FolderDetailView(filter: account.unwrappedFolder)) {
                HStack {
                    Image(systemName: "folder")
                    Text(account.unwrappedFolder)
                }
            }
        }
    }
}

struct GroupsListView_Previews: PreviewProvider {
    static var previews: some View {
        FolderListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
