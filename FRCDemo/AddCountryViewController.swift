import UIKit

class AddCountryViewController: UIViewController {
    @IBOutlet weak var population: UITextField!
    @IBOutlet weak var currency: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        retainCycle { (val) in
//            print(val)
//            self.save(UIButton())
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sneder: UIButton) {
        
        if !(name.text?.isEmpty)! && !(population.text?.isEmpty)! && !(location.text?.isEmpty)! && !(currency.text?.isEmpty)! {
            
            DataManager.shared.addCountry(name: name.text!, currency: currency.text!, location: location.text!, population: population.text!)
            navigationController?.popViewController(animated: true)
        }
    }
}
