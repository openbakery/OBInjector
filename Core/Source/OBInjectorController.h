//
// Created by Rene Pirringer on 18.12.15.
// Copyright (c) 2015 Rene Pirringer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OBInjector;


@interface OBInjectorController : NSObject

+ (OBInjectorController *)sharedController;


@property(nonatomic, readonly) OBInjector *injector;

@end