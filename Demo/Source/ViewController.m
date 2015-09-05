//
//
// Author: René Pirringer
//
//

#import "ViewController.h"
#import "MyService.h"
#import "NSObject+OBInjector.h"

@interface ViewController ()
@property(nonatomic, strong) MyService *myService;
@property(nonatomic, strong) NSDate *currentDate;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation ViewController {
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	self.launchDateLabel.text = [self.dateFormatter stringFromDate:[self.myService launchDate]];
	self.currentDateLabel.text = [self.dateFormatter stringFromDate:self.currentDate];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	[self injectDependenciesTo:segue.destinationViewController];
}



@end
