//
// Created by René Pirringer on 31.08.20.
// Copyright (c) 2020 Rene Pirringer. All rights reserved.
//

#import "OBRegisteredProperty.h"


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


- (NSString *)description {
	NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
	[description appendFormat:@"self.name=%@", self.name];
	[description appendFormat:@", self.instanceClass=%@", self.instanceClass];
	[description appendString:@">"];
	return description;
}


@end