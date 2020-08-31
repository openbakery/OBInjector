//
//
// Author: René Pirringer
//
//



#import <objc/runtime.h>
#import "OBPropertyInjector.h"



@interface OBPropertyInjector()
@property (nonatomic, strong) NSMutableArray *registeredProperties;
@end

@implementation OBPropertyInjector {
}


- (id)init {
	self = [super init];
	if (self) {
		self.registeredProperties = [[NSMutableArray alloc] init];
	}
	return self;
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
	for (OBRegisteredProperty *registeredProperty in self.registeredProperties) {
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


- (void)registerProperty:(NSString *)property withInstance:(id <NSObject>)instance {
	if ([self propertyForName:property]) {
		return;
	}

	OBRegisteredProperty *registeredProperty = [[OBRegisteredProperty alloc] initWithName:property object:instance];
	[self.registeredProperties addObject:registeredProperty];
}


- (void)registerProperty:(NSString *)property withBlock:(OBInjectorCreateInstanceBlock)block {
	NSAssert(block, @"Given block is nil");
	OBRegisteredProperty *registeredProperty = [[OBRegisteredProperty alloc] initWithName:property block:block];
	[self.registeredProperties addObject:registeredProperty];
	
}

- (id)instanceForClass:(Class)clazz {
	for (OBRegisteredProperty *registeredProperty  in self.registeredProperties) {
		if ([registeredProperty.instanceClass isSubclassOfClass:clazz]) {
			return registeredProperty.instance;
		}
	}
	return nil;
}

- (OBRegisteredProperty *)propertyForName:(NSString *)propertyName {
	for (OBRegisteredProperty *registeredProperty in self.registeredProperties) {
		if ([registeredProperty.name isEqualToString:propertyName]) {
			return registeredProperty;
		}
	}
	return nil;
}

- (id)instanceForProperty:(NSString *)propertyName {
	return [self propertyForName:propertyName].instance;
}

- (void)deleteProperty:(NSString *)propertyName {
	OBRegisteredProperty *registeredProperty = [self propertyForName:propertyName];
	if (registeredProperty) {
		[self.registeredProperties removeObject:registeredProperty];
	}
}

@end