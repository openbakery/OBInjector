//
//
// Author: René Pirringer
//
//

#import <Foundation/Foundation.h>

@class OBInjector;

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
 * Property to the injector instance
 *
 * @returns an injector instance
 */
@property(nonatomic, readonly) OBInjector *injector;

@end