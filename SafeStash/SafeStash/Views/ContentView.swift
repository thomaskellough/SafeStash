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
                        
                        Button(action: {
                            self.addTestAccounts()
                        }) {
                            Text("Add Test Accounts")
                        }
                    }
                )
                .sheet(isPresented: $isShowingAddNewAccountView) {
                    AddNewAccount(newAccount: NewAccount())
                }
        }
    }
    
    // https://onlinerandomtools.com/generate-random-csv
    func addTestAccounts() {
        let folders = ["Entertainment", "Work", "Emails", "Games", "Travel"]
        let usernames = ["lamp","that","seed","gradually","baby","film","material","picture","grass","gray","package","cage","pain","behind","has","weather","whenever","wherever","supply","owner","railroad","length","shelter","escape","fence","something","native","electricity","work","hospital", "rose","probably","unless","treated","doing","die","speech","determine","share","home","enemy","community","reach","quick","tropical","bell","writing","shade","learn","relationship","pink","moving","lamp","sound","men","film","brass","box","we","list"]
        
        for username in usernames {
            let testAccount = Account(context: self.moc)
            testAccount.id = UUID()
            testAccount.name = username
            testAccount.username = "\(username)Username"
            testAccount.email = "\(username)@icloud.com"
            testAccount.folder = folders.randomElement()
            testAccount.password = UUID().uuidString
            
            let pinRange = 1...9999
            let pin = Int(pinRange.randomElement() ?? 0)
            let formattedPin = String(format: "%04d", pin)
            testAccount.pin = formattedPin
            
            let randomNotesArray = Array(usernames.shuffled().prefix(Int.random(in: 0..<usernames.count)))
            testAccount.notes = ListFormatter.localizedString(byJoining: randomNotesArray)
            
            if moc.hasChanges {
                try? self.moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
