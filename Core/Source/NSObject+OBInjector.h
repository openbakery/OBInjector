//
//
// Author: René Pirringer
//
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSObject (OBInjector)

/**
 * Injects the instances to the registered properties of the given object.
 * Note that only values are injected where the property is nil.
 */
- (void)injectDependenciesTo:(NSObject *)injectTo;


@end