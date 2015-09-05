//
// Created by Rene Pirringer on 05/09/15.
// Copyright (c) 2015 Rene Pirringer. All rights reserved.
//

#import "MyService.h"


@implementation MyService {

	NSDate *_launchDate;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		_launchDate = [NSDate date];
	}
	return self;
}

- (NSDate *)launchDate {
	return _launchDate;
}
@end