//
//  CoreDataManager.swift
//  ChainTechDemoTask
//
//  Created by Mitul Markana on 20/05/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PasswordManagerModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



class AccountManager {
    static let shared = AccountManager()
    let cryptoManager = CryptoManager()
    private init() {}
    
    let coreDataManager = CoreDataManager.shared
    
    // MARK: - CRUD Operations
    
    func addAccount(accountData: AccountData) {
        let context = coreDataManager.viewContext
        let newAccount = Account(context: context)
        newAccount.accountName = accountData.accountName
        newAccount.username = accountData.username
        newAccount.password = cryptoManager.encrypt(accountData.password)
        coreDataManager.saveContext()
    }
    
    func updatePassword(account: AccountData, newPassword: String, accounName: String, username: String) {
        let context = coreDataManager.viewContext
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "accountName == %@", account.accountName)
        do {
            let accounts = try context.fetch(fetchRequest)
            if let accountToUpdate = accounts.first {
                accountToUpdate.accountName = accounName
                accountToUpdate.username = username
                accountToUpdate.password = cryptoManager.encrypt(newPassword)
                coreDataManager.saveContext()
            } else {
                print("Account not found.")
            }
        } catch {
            print("Error updating password: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount(accountData: AccountData) {
        let context = coreDataManager.viewContext
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "accountName == %@", accountData.accountName)
        do {
            let accounts = try context.fetch(fetchRequest)
            if let accountToDelete = accounts.first {
                context.delete(accountToDelete)
                coreDataManager.saveContext()
            } else {
                print("Account not found.")
            }
        } catch {
            print("Error fetching accounts: \(error.localizedDescription)")
        }
    }
    
    func getAccountData() -> [AccountData] {
        let context = coreDataManager.viewContext
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        do {
            let accounts = try context.fetch(fetchRequest)
            return accounts.map { account in
                AccountData(accountName: account.accountName ?? "",
                            username: account.username ?? "",
                            password:  cryptoManager.decrypt(account.password ?? "") ?? "")
            }
        } catch {
            print("Error fetching account data: \(error.localizedDescription)")
            return []
        }
    }
}
