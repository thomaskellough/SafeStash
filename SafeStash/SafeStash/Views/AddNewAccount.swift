//
//  AddNewAccount.swift
//  SafeStash
//
//  Created by Thomas Kellough on 12/19/20.
//

import SwiftUI

struct AddNewAccount: View {
    @ObservedObject var newAccount: NewAccount
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var moc
    @State private var selectedStrength = 0
    @State private var notesText = ""
    
    var body: some View {
        let notesBinding = Binding<String>(get: {
            self.notesText
        }, set: {
            self.notesText = $0
            newAccount.notes = self.notesText
        })
        VStack {
            Text("Add new account")
                .font(.largeTitle)
                .padding(.bottom)
            VStack(spacing: 10) {
                AddNewAccountFolderListItem(newAccount: newAccount, title: "Folder", placeholder: "Entertainment/Work/Etc.")               
                AddNewAccountListItem(newAccount: newAccount, title: "Name", placeholder: "Gmail/Netflix/etc.")
                AddNewAccountListItem(newAccount: newAccount, title: "Username", placeholder: "Johnny.Appleseed")
                AddNewAccountListItem(newAccount: newAccount, title: "Password", placeholder: "Password")
                AddNewAccountListItem(newAccount: newAccount, title: "Pin", placeholder: "1234")
                AddNewAccountListItem(newAccount: newAccount, title: "Email", placeholder: "Johnny.appleseed@icloud.com")
            }
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Notes")
                TextEditor(text: notesBinding)
                    .border(Color.gray, width: 1)
            }
            
            .frame(height: 250)
            
            Spacer()
            
            Button(action: {
                self.save()
            }, label: {
                Text("Save")
                    .padding()
                    .frame(width: UIScreen.main.bounds.size.width / 2)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(40)
            })
            .padding()
        }
        .padding()
        .navigationBarTitle("Add new account")
    }
    
    func save() {
        guard newAccount.name != "" else {
            // show alert
            return
        }
        let cdNewAccount = Account(context: self.moc)
        cdNewAccount.id = UUID()
        cdNewAccount.name = newAccount.name
        cdNewAccount.email = newAccount.email
        cdNewAccount.password = newAccount.password
        cdNewAccount.pin = newAccount.pin
        cdNewAccount.username = newAccount.username
        cdNewAccount.notes = newAccount.notes
        cdNewAccount.timestamp = Date()
        cdNewAccount.folder = newAccount.folder
        
        if moc.hasChanges {
            try? self.moc.save()
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddNewAccount_Previews: PreviewProvider {
    static var previews: some View {
        AddNewAccount(newAccount: NewAccount())
    }
}
