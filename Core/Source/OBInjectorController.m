//
// Created by Rene Pirringer on 18.12.15.
// Copyright (c) 2015 Rene Pirringer. All rights reserved.
//

#import "OBInjectorController.h"
#import "OBInjector.h"

@interface OBInjector(Private)
- (instancetype)initPrivate;
@end


@implementation OBInjectorController {
	OBInjector *_injector;
}


+ (OBInjectorController *)sharedController {
	static OBInjectorController *sharedController = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
			sharedController = [[OBInjectorController alloc] init];
	});
	return sharedController;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		_injector = [[OBInjector alloc] initPrivate];
	}
	return self;
}


- (OBInjector *)injector {
	return _injector;
}


@end