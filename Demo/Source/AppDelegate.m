//
//
// Author: René Pirringer
//
//


#import "AppDelegate.h"
#import "OBInjector.h"
#import "MyService.h"
#import "OBInjectorController.h"
#import "NSObject+OBInjector.h"

@interface AppDelegate ()

@end

@implementation AppDelegate {
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self configureInjector];

	UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
	[self injectDependenciesTo:navigationController.topViewController];
	return YES;
}

- (void)configureInjector {
	OBInjector *injector = [OBInjectorController sharedController].injector;

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
