//
//
// Author: René Pirringer
//
//


#import "AppDelegate.h"
#import "OBInjector.h"
#import "NSObject+OBInjector.h"

@interface AppDelegate ()

@end

@implementation AppDelegate {
	OBInjector *_injector;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self configureInjector];

	[self.injector injectDependenciesTo:self.window.rootViewController];
	return YES;
}

- (void)configureInjector {
	_injector = [[OBInjector alloc] init];
}

- (OBInjector *)injector {
	return _injector;

}


@end
