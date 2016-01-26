//
//  ViewController.swift
//  OBInjectorSwiftDemo
//
//  Created by Rene Pirringer on 26.01.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var myService: MyService?
	var dateFormatter: NSDateFormatter?
	var currentDate: NSDate?
	
	@IBOutlet var launchDateLabel: UILabel!
	@IBOutlet var currentDateLabel: UILabel!

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		NSLog("MyService launchDate: \(myService?.launchDate)")
		
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func viewWillAppear(animated:Bool) {
		let launchDate = (dateFormatter?.stringFromDate((myService?.launchDate)!))!
		self.launchDateLabel.text = "\(launchDate)"
		let currentDate = (dateFormatter?.stringFromDate(NSDate()))!
		self.currentDateLabel.text = "\(currentDate)"
	}
	
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		OBInjectorController.injectDependenciesTo(segue.destinationViewController)
	}

}

