//
//
// Author: René Pirringer
//
//

#import <Foundation/Foundation.h>

@class OBPropertyInjector;

typedef void (^OBInjectorConfigureInjectorBlock)(OBPropertyInjector *injector);


/**
 * The OBInjectorController is the central class to create and get access to the injector
 */
@interface OBInjectorController : NSObject

/**
 * Method to get the instance of the OBInjectorController
 *
 * @returns an OBInjectorController instance
 */
+ (OBInjectorController *)sharedController;


/**
 * Use this method to configure the injector
 * This method is only called once
 */
+ (void)configureInjector:(OBInjectorConfigureInjectorBlock)block;


/**
 * Injects the instances to the registered properties of the given object.
 * Note that only values are injected where the property is nil.
 *
 * @param injectTo Object where the dependencies should be injected
 */
+ (void)injectDependenciesTo:(NSObject *)injectTo;


/**
 * Property to the injector instance
 *
 * @returns an injector instance, or null if the injector was not configured
 */
@property(nonatomic, readonly) OBPropertyInjector *injector;

@end