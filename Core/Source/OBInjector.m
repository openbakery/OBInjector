//
//
// Author: René Pirringer
//
//



#import <objc/runtime.h>
#import "OBInjector.h"

@interface OBRegisteredProperty : NSObject


@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) Class instanceClass;

- (instancetype)initWithName:(NSString *)name block:(OBInjectorCreateInstanceBlock)block;
- (instancetype)initWithName:(NSString *)name object:(NSObject *)object;

- (NSObject *)instance;


@end

@implementation OBRegisteredProperty {
	NSString *_name;
	OBInjectorCreateInstanceBlock _block;
	NSObject *_instance;
	Class _instanceClass;
	
}

- (instancetype)initWithName:(NSString *)name block:(OBInjectorCreateInstanceBlock)block {
	self = [super init];
	if (self) {
		_name = name;
		_block = [block copy];
		_instanceClass = [block() class];
	}
	return self;
}

- (instancetype)initWithName:(NSString *)name object:(NSObject *)object {
	self = [super init];
	if (self) {
		_name = name;
		_instance = object;
		_instanceClass = [object class];
	}
	return self;
}

- (NSString *)name {
	return _name;
}

- (Class)instanceClass {
	return _instanceClass;
}

- (NSObject *)instance {
	if (_block) {
		return _block();
	}
	return _instance;
}


@end


@implementation OBInjector
{
	NSMutableArray *_registeredProperties;
}

- (id)init {
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
	                                   reason:@"Use the OBInjectorController for getting a OBInjector instance!!!"
	                                 userInfo:nil];
}

- (id)initPrivate {
	self = [super init];
	if (self) {
		[self reset];
	}
	return self;
}

- (void)reset {
	_registeredProperties = [[NSMutableArray alloc] init];
}


- (BOOL)injectPropertyTo:(NSObject *)injectTo registredProperty:(OBRegisteredProperty *)registeredProperty {

	objc_property_t propertyClass = class_getProperty([injectTo class], [registeredProperty.name UTF8String]);
	if (propertyClass != NULL)
	{
		const char *type = property_getAttributes(propertyClass);
		NSString *typeString = [NSString stringWithUTF8String:type];
		NSArray *attributes = [typeString componentsSeparatedByString:@","];
		NSString *typeAttribute = [attributes objectAtIndex:0];
		
		if ([typeAttribute hasPrefix:@"T@\"<"]) {
			// is protocol
			NSString *type = [typeAttribute substringWithRange:NSMakeRange(4, [typeAttribute length] - 6)];
			Protocol *p = NSProtocolFromString(type);
			if ([registeredProperty.instanceClass conformsToProtocol:p]) {
				return [self setProperty:registeredProperty to:injectTo];
			}
		} else if ([typeAttribute hasPrefix:@"T@\""]) {
			NSString *type = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length] - 4)];
			Class objectClass = NSClassFromString(type);
			if ([registeredProperty.instanceClass isSubclassOfClass:objectClass]) {
				return [self setProperty:registeredProperty to:injectTo];
			}
		}
	}
	return NO;
}

- (BOOL)setProperty:(OBRegisteredProperty *)property to:(NSObject *)injectTo {
	if ([injectTo valueForKey:property.name] == nil) {
		[injectTo setValue:property.instance forKey:property.name];
		return YES;
	}
	return NO;
}

- (void)injectDependenciesTo:(NSObject *)injectTo
{
	BOOL didInjectDependencies = NO;
	for (OBRegisteredProperty *registeredProperty in _registeredProperties) {
		if ([self injectPropertyTo:injectTo registredProperty:registeredProperty]) {
			didInjectDependencies = YES;
		}
	}

	if (!didInjectDependencies) {
		return;
	}

	// only call the delegate is a value was injected
	if ([injectTo conformsToProtocol:@protocol(OBInjectorDelegate)]) {
		NSObject <OBInjectorDelegate> *delegate = (NSObject <OBInjectorDelegate> *) injectTo;
		if ([delegate respondsToSelector:@selector(didInjectDependencies)]) {
			[delegate didInjectDependencies];
		}
	}
}


- (void)registerProperty:(NSString *)property withInstance:(id <NSObject>)instance
{
	OBRegisteredProperty *registredProperty = [[OBRegisteredProperty alloc] initWithName:property object:instance];
	[_registeredProperties addObject:registredProperty];
}


- (void)registerProperty:(NSString *)property withBlock:(OBInjectorCreateInstanceBlock)block {
	NSAssert(block, @"Given block is nil");
	OBRegisteredProperty *registredProperty = [[OBRegisteredProperty alloc] initWithName:property block:block];
	[_registeredProperties addObject:registredProperty];
	
}

- (id)instanceForClass:(Class)clazz {
	for (OBRegisteredProperty *registeredProperty  in _registeredProperties) {
		if ([registeredProperty.instanceClass isSubclassOfClass:clazz]) {
			return registeredProperty.instance;
		}
	}
	return nil;
}

- (id)instanceForProperty:(NSString *)property {
	return [_registeredProperties valueForKey:property];
}


@end