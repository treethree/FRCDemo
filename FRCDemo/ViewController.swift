
import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [Country]()
    
    let frc: NSFetchedResultsController = DataManager.shared.fetchedResultsControllerCountry
    
    override func viewDidLoad() {
        super.viewDidLoad()

        frc.delegate = self
        do {
            try frc.performFetch() //fetch data from data base
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dm = DataManager.shared
        dm.saveContext()  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return frc.sections!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (frc.fetchedObjects?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            
            return UITableViewCell()
        }
        
        let country = frc.object(at: indexPath)
        cell.textLabel?.text = country.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let country = frc.object(at: indexPath)
            
            DataManager.shared.mainContext.delete(country)
            DataManager.shared.saveContext()
            //save the context...
            
            //when we deleted objects from frc, content of frc got changed.
        }
    }
    
    func setCell(_ cell: UITableViewCell, at indexPath: IndexPath) {

        let country = frc.object(at: indexPath)
        cell.textLabel?.text = country.name
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UpdateCountryViewController") as? UpdateCountryViewController
        let country = frc.object(at: indexPath)
        vc?.name = country.name
        vc?.location = country.location
        vc?.currency = country.currency
        vc?.population = String(country.population)
        vc?.index = indexPath.row
        navigationController?.pushViewController(vc!, animated: true)
        
    }
}


//delete one row from table view. rfc content changed ->
extension ViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
       
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath){
                setCell(cell, at: indexPath)
            }
        case .move: //re-arranging rows.
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        }
    }
}


//1 -> rowid 0

//2 -> rowid 1

// tableView.beginUpdates() + tableView.endUpdates() similar to tableView.reloadData() //without animation
