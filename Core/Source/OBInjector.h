//
//
// Author: René Pirringer
//
//



#import <Foundation/Foundation.h>

typedef id<NSObject> (^OBInjectorCreateInstanceBlock)(void);


@protocol OBInjectorDelegate

@optional
/**
 * The didInjectDependencies method is called when a property was injected.
 * If no value was injected, then this method is not called.
 *
 * You can use this to finish the initialization of an instance.
 */
- (void)didInjectDependencies;

@end

@interface OBInjector : NSObject


/**
 * Injects the instances to the registered properties of the given object.
 * Note that only values are injected where the property is nil.
 */
- (void)injectDependenciesTo:(NSObject *)injectTo;


/**
 * Registers a property that can be injected to a object.
 * The given instance is then set as property value of the object using the injectDependenciesTo method.
 */
- (void)registerProperty:(NSString *)property withInstance:(id<NSObject>)instance;

/**
 * Registers a property that can be injected to a object.
 * When the property is injected then the given block is called and the result is injected.
 */
- (void)registerProperty:(NSString *)property withBlock:(OBInjectorCreateInstanceBlock)block;

/**
 * Method to get the instance of the given class
 *
 * @returns an instance for the giving class
 */
- (id)instanceForClass:(Class)clazz;

@end