//
//  AccountDetailView.swift
//  SafeStash
//
//  Created by Thomas Kellough on 12/29/20.
//

import SwiftUI

struct AccountDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var isEditing = false
    @State private var username = ""
    @State private var password = ""
    @State private var pin = ""
    @State private var email = ""
    @State private var notesText = ""
    var account: Account
    
    var body: some View {
        let notesBinding = Binding<String>(get: {
            if self.notesText != "" {
                return self.notesText
            } else {
                return " "
            }
        }, set: {
            self.notesText = $0
        })
        
        Form {
            VStack(alignment: .leading) {
                Text("Username")
                isEditing ? TextField(account.unwrappedUsername, text: $username) : nil
                !isEditing ? Text(account.unwrappedUsername) : nil
            }
            VStack(alignment: .leading) {
                Text("Password")
                isEditing ? TextField(account.unwrappedPassword, text: $password) : nil
                !isEditing ? Text(account.unwrappedPassword) : nil
            }
            VStack(alignment: .leading) {
                Text("Pin")
                isEditing ? TextField(account.unwrappedPin, text: $pin) : nil
                !isEditing ? Text(account.unwrappedPin) : nil
            }
            VStack(alignment: .leading) {
                Text("Email")
                isEditing ? TextField(account.unwrappedEmail, text: $email) : nil
                !isEditing ? Text(account.unwrappedEmail) : nil
            }
            VStack(alignment: .leading) {
                Text("Notes")
                isEditing ? TextEditor(text: notesBinding).border(Color.gray, width: 1) : nil
                !isEditing ? Text(account.unwrappedNotes) : nil
            }
            
        }
        .navigationTitle("\(account.unwrappedName)")
        .navigationBarItems(trailing:
            !isEditing ? Button("Edit") {
                self.isEditing = true
                self.notesText = account.unwrappedNotes
            } : Button("Save") {
                self.isEditing = false
                self.save()
            }
        )
    }
    
    func save() {
        let fetchRequest = Account.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", account.id!.uuidString)
        if let accounts = try? self.moc.fetch(fetchRequest) as? [Account] {
            let account = accounts[0]
            self.username != "" ? account.username = self.username : nil
            self.password != "" ? account.password = self.password : nil
            self.pin != "" ? account.pin = self.pin : nil
            self.email != "" ? account.email = self.email : nil
            self.notesText != "" ? account.notes = self.notesText.trimmingCharacters(in: .whitespaces) : nil
            
            try? self.moc.save()
        }
        
        
//        do {
//            let accounts = try self.moc.fetch(fetchRequest)
//            if !accounts.isEmpty {
//                return accounts[0]
//            }
//        } catch let error as NSError {
//            print("Could not fetch. \(error.localizedDescription), \(error.userInfo)")
//        }
    }
}

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailView(account: Account())
    }
}
