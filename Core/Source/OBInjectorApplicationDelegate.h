//
// Created by Rene Pirringer on 05/09/15.
// Copyright (c) 2015 Rene Pirringer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OBInjector;

@protocol OBInjectorApplicationDelegate <UIApplicationDelegate>

@property (nonatomic, readonly) OBInjector *injector;

@end