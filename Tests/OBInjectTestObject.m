//
// ELO 
//
// Created by rene on 05.07.13.
// Copyright 2013. All rights reserved.
//
// 
//


#import "OBInjectTestObject.h"



@implementation OBInjectTestObject
{

}

- (void)didInjectDependencies {
	self.didInject = YES;
}

@end