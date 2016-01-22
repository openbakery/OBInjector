//
//
// Author: René Pirringer
//
//


#import "AppDelegate.h"
#import "OBPropertyInjector.h"
#import "MyService.h"
#import "OBInjectorController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate {
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self configureInjector];

	UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
	[OBInjectorController injectDependenciesTo:navigationController.topViewController];
	return YES;
}

- (void)configureInjector {
	OBPropertyInjector *injector = [OBInjectorController sharedController].injector;

	MyService *myService = [[MyService alloc] init];
	[injector registerProperty:@"myService" withInstance:myService];

	[injector registerProperty:@"currentDate" withBlock:^{
			return [NSDate date];
	}];

	NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateStyle = NSDateFormatterNoStyle;
	dateFormatter.timeStyle = NSDateFormatterMediumStyle;
	[injector registerProperty:@"dateFormatter" withInstance:dateFormatter];
}



@end
