//
//
// Author: René Pirringer
//
//


#import "NSObject+OBInjector.h"
#import "OBInjectorController.h"
#import "OBInjector.h"


@implementation NSObject (OBInjector)


- (void)injectDependenciesTo:(NSObject *)injectTo {
	[OBInjectorController injectDependenciesTo:injectTo];
}



@end