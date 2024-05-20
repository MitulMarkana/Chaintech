//
//  Account+CoreDataProperties.swift
//  ChainTechDemoTask
//
//  Created by Mitul Markana on 20/05/24.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var accountName: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension Account : Identifiable {

}
