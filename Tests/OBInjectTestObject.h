//
// ELO 
//
// Created by rene on 05.07.13.
// Copyright 2013. All rights reserved.
//
// 
//


#import <Foundation/Foundation.h>
#import "OBInjector.h"


@interface OBInjectTestObject : NSObject  <OBInjectorDelegate>

@property (nonatomic, strong) NSString *injectTest;

@property (nonatomic, assign) BOOL didInject;


@end