//
//  ResultViewController.swift
//  AnimalTest
//
//  Created by Tatsiana Pauliukova on 17.11.22.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var yourPetLabel: UILabel!
    @IBOutlet var descriptionOfYourAnimalLabel: UILabel!
    
    var pollResults: [Answer]!

    @IBAction func doneButtonPress(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
     
    }
    
    private func testResults() {
        
        var dog = 0
        var cat = 0
        var rabbit = 0
        var turtle = 0
        
        var slovar: [AnimalType: Int] = [:]

        for result in pollResults {
            if result.type == .dog {
              dog += 1
                slovar.updateValue(dog, forKey: result.type)
            } else if result.type == .cat {
                cat += 1
                slovar.updateValue(cat, forKey: result.type)
            } else if result.type == .rabbit {
                rabbit += 1
                slovar.updateValue(rabbit, forKey: result.type)
            } else if result.type == .turtle {
                turtle += 1
                slovar.updateValue(turtle, forKey: result.type)
            }
           
        }
      
            if dog > cat && dog > rabbit && dog > turtle {
                yourPetLabel.text = String(AnimalType.dog.rawValue)
                descriptionOfYourAnimalLabel.text = AnimalType.dog.definition
            } else  if cat > dog && cat > rabbit && cat > turtle {
                yourPetLabel.text = String(AnimalType.cat.rawValue)
                descriptionOfYourAnimalLabel.text = AnimalType.cat.definition
            } else  if rabbit > dog && rabbit > cat && rabbit > turtle {
                yourPetLabel.text = String(AnimalType.rabbit.rawValue)
                descriptionOfYourAnimalLabel.text = AnimalType.rabbit.definition
            } else  if turtle > dog && turtle > cat && turtle > rabbit {
                yourPetLabel.text = String(AnimalType.turtle.rawValue)
                descriptionOfYourAnimalLabel.text = AnimalType.turtle.definition
            }
        }

    }

