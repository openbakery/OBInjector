//
//
// Author: René Pirringer
//
//


#import "AppDelegate.h"
#import "OBInjector.h"
#import "MyService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate {
	OBInjector *_injector;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self configureInjector];

	UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
	[self.injector injectDependenciesTo:navigationController.topViewController];
	return YES;
}

- (void)configureInjector {
	_injector = [[OBInjector alloc] init];


	MyService *myService = [[MyService alloc] init];
	[_injector registerProperty:@"myService" withInstance:myService];

	[_injector registerProperty:@"currentDate" withBlock:^{
			return [NSDate date];
	}];

	NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateStyle = NSDateFormatterNoStyle;
	dateFormatter.timeStyle = NSDateFormatterMediumStyle;
	[_injector registerProperty:@"dateFormatter" withInstance:dateFormatter];


}

- (OBInjector *)injector {
	return _injector;

}


@end
