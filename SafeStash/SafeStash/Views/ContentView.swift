//
//  ContentView.swift
//  SafeStash
//
//  Created by Thomas Kellough on 12/19/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Account.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Account.name, ascending: true)
    ]) var accounts: FetchedResults<Account>
    
    @State private var isShowingAddNewFolderView = false
    @State private var isShowingAddNewAccountView = false
    
    var body: some View {
        NavigationView {
            FolderListView()
                .navigationBarTitle("Folders")
                .navigationBarItems(trailing:
                    HStack {
                        Button(action: {
                            self.isShowingAddNewAccountView = true
                        }) {
                            Image(systemName: "doc.badge.plus")
                        }
                    }
                )
                .sheet(isPresented: $isShowingAddNewAccountView) {
                    AddNewAccount(newAccount: NewAccount())
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
