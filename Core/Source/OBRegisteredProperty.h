//
// Created by René Pirringer on 31.08.20.
// Copyright (c) 2020 Rene Pirringer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id<NSObject> (^OBInjectorCreateInstanceBlock)(void);


@interface OBRegisteredProperty : NSObject


@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) Class instanceClass;

- (instancetype)initWithName:(NSString *)name block:(OBInjectorCreateInstanceBlock)block;
- (instancetype)initWithName:(NSString *)name object:(NSObject *)object;

- (NSObject *)instance;

- (NSString *)description;


@end