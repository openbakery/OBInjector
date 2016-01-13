//
//
// Author: René Pirringer
//
//


#import "NSObject+OBInjector.h"
#import "OBInjectorController.h"
#import "OBPropertyInjector.h"


@implementation NSObject (OBInjector)


- (void)injectDependenciesTo:(NSObject *)injectTo {
	[OBInjectorController injectDependenciesTo:injectTo];
}



@end