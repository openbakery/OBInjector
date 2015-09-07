//
//
// Author: René Pirringer
//
//



#import <Foundation/Foundation.h>

typedef id<NSObject> (^OBInjectorCreateInstanceBlock)(void);

/**
 * The OBInjectorDelegate protocol can be implemented when a instance need to know when the dependency injection took place
 */
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

/**
 * The OBInjector class handles the injects dependencies to properties instances that where registerd.
 * 
 */
@interface OBInjector : NSObject


/**
 * Injects the instances to the registered properties of the given object.
 * Note that only values are injected where the property is nil.
 * @param injectTo Object where the dependencies should be injected
 */
- (void)injectDependenciesTo:(NSObject *)injectTo;


/**
 * Registers a property that can be injected to a object.
 * The given instance is then set as property value of the object using the injectDependenciesTo method.
 *
 * @param property Name of the property
 * @param instance Object that should be injected
 */
- (void)registerProperty:(NSString *)property withInstance:(id<NSObject>)instance;

/**
 * Registers a property that can be injected to a object.
 * When the property is injected then the given block is called and the result is injected.
 *
 * @param property Name of the property
 * @param block Block that is executed and the returned result is injected
 */
- (void)registerProperty:(NSString *)property withBlock:(OBInjectorCreateInstanceBlock)block;

/**
 * Method to get the instance of the given class
 * @param clazz Class where a instance should be returned
 * @returns an instance for the giving class
 */
- (id)instanceForClass:(Class)clazz;

@end