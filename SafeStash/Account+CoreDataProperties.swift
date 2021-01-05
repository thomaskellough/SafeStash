//
//  Account+CoreDataProperties.swift
//  SafeStash
//
//  Created by Thomas Kellough on 1/4/21.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var email: String?
    @NSManaged public var folder: String?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var password: String?
    @NSManaged public var pin: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var username: String?
    @NSManaged public var id: UUID?
    
    // MARK: Unwrapped properties
    public var unwrappedFolder: String {
        folder ?? "Unknown folder"
    }
    public var unwrappedName: String {
        name ?? "Unknown name"
    }
    public var unwrappedUsername: String {
        username ?? "Unknown username"
    }
    public var unwrappedEmail: String {
        email ?? "Unknown email"
    }
    public var unwrappedPassword: String {
        password ?? "Unknown password"
    }
    public var unwrappedNotes: String {
        notes ?? "Unknown notes"
    }
    
    // MARK: Example Account
    public var example: Account {
        let account = Account()
        account.email = "Example email"
        account.password = "Example password"
        account.pin = "1234"
        account.folder = "Example folder"
        account.notes = "Example notes"
        
        return account
    }
}

extension Account : Identifiable {

}
