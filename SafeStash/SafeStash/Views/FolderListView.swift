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
    @State private var folders: [String] = []
    
    var body: some View {
        List(folders, id: \.self) { folder in
            NavigationLink(destination: FolderDetailView(filter: folder)) {
                HStack {
                    Image(systemName: "folder")
                    Text(folder)
                }
            }
        }
        .onAppear(perform: filterFolders)
    }
    
    func filterFolders() {
        var all: [String] = []
        for account in accounts {
            all.append(account.unwrappedFolder)
        }
        self.folders = Array(Set(all))
    }
}

struct GroupsListView_Previews: PreviewProvider {
    static var previews: some View {
        FolderListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
