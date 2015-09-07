//
//
// Author: René Pirringer
//
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Category so that every object can inject dependencies to other objects.
 */
@interface NSObject (OBInjector)

/**
 * Injects the instances to the registered properties of the given object.
 * Note that only values are injected where the property is nil.
 *
 * @param injectTo Object where the dependencies should be injected
 */
- (void)injectDependenciesTo:(NSObject *)injectTo;


@end