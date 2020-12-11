//
//  ViewController.swift
//  OBInjectorSwiftDemo
//
//  Created by Rene Pirringer on 26.01.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var myService: MyService!
    var dateFormatter: DateFormatter!
	var currentDate: NSDate!
	
	@IBOutlet var launchDateLabel: UILabel!
	@IBOutlet var currentDateLabel: UILabel!

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
        NSLog("MyService launchDate: \(String(describing: myService?.launchDate))")
		
		// Do any additional setup after loading the view, typically from a nib.
	}

    override func viewWillAppear(_ animated:Bool) {
        self.launchDateLabel.text = "\(dateFormatter.string(from: myService.launchDate as Date)))"
		self.currentDateLabel.text = "\(dateFormatter.string(from: currentDate as Date)))"
	}
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        OBInjectorController.injectDependencies(to: segue.destination)
	}

}

