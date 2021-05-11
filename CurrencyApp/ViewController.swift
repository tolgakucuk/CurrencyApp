//
//  ViewController.swift
//  CurrencyApp
//
//  Created by Tolga on 10.05.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        //1)Request & Session
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=55de1cc63c53ffeffe40be838c1c68dc")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if(error != nil){
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                //2)Response & Data
                if(data != nil){
                    do {
                        let jSonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //3)Parsing & jSon Serialization
                        DispatchQueue.main.async {
                            if let rates = jSonResponse["rates"] as? [String : Any]{
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                
                                if let turkish = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY: \(turkish)"
                                }
                            }
                        }
                    } catch{
                        print("error")
                    }
                }else{
                    print("Data is null")
                }
            }
        }
        task.resume()
        
    }
    
}

