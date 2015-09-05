//
//
// Author: René Pirringer
//
//


#import "NSObject+OBInjector.h"
#import "OBInjector.h"
#import "OBInjectorApplicationDelegate.h"


@implementation NSObject (OBInjector)


- (void)injectDependenciesTo:(NSObject *)injectTo {
	NSObject<UIApplicationDelegate> *delegate = [UIApplication sharedApplication].delegate;

	if ([delegate conformsToProtocol:@protocol(OBInjectorApplicationDelegate)]) {
		id<OBInjectorApplicationDelegate> injectorApplicationDelegate = (id<OBInjectorApplicationDelegate>)delegate;
		[injectorApplicationDelegate.injector injectDependenciesTo:injectTo];
	}	else {
		NSAssert(NO, @"delegate does not implement the protocol OBInjectorApplicationDelegate");
	}
}



@end