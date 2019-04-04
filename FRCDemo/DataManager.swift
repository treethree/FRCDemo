
import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "FRCDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var mainContext: NSManagedObjectContext {
        
        return persistentContainer.viewContext
    }
    
    
    func addCountry(name: String, currency: String, location: String, population: String) {
        
        let countryRecord = Country(context: mainContext)
        countryRecord.name = name
        countryRecord.currency = currency
        countryRecord.location = location
        countryRecord.population = Int64(population)!
        saveContext()
    }
    
    func updateCountry(name: String, currency: String, location: String, population: String, index: Int) {
        do{
            let test = try mainContext.fetch(fetchedResultsControllerCountry.fetchRequest)
            test[index].name = name
            test[index].currency = currency
            test[index].location = location
            test[index].population = Int64(population)!
            saveContext()
        }catch{
            print(error)
        }
    }
    
    lazy var fetchedResultsControllerCountry: NSFetchedResultsController<Country> = {
        
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "population", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }()
}

//DataManager is a manager class preferably a singleton class used to manage all database releated activities.

//NetworkManager/APIHandler: for hanlding network call's or API call's

//batter code separation.



