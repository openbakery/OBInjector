//
// ELO 
//
// Created by rene on 05.07.13.
// Copyright 2013. All rights reserved.
//
// 
//


@import XCTest;

#import "OBPropertyInjector.h"
#import "OBInjectTestObject.h"
#import "OBInjectorController.h"



@interface OBPropertyInjector (Private)
- (instancetype)initPrivate;
@property (nonatomic, strong) NSMutableArray *registeredProperties;
@end

@interface OBPropertyInjectorTest : XCTestCase

@end

@implementation OBPropertyInjectorTest
{
	OBPropertyInjector *injector;
	OBInjectTestObject *testObject;
}

- (void)setUp {
	[super setUp];
	injector = [[OBPropertyInjector alloc] init];
	testObject = [[OBInjectTestObject alloc] init];
}


- (void)testInjector {
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector injectDependenciesTo:testObject];
	XCTAssertEqual(testObject.injectTest, @"testString");
}

- (void)testInjectorWithWrongClass {
	[injector registerProperty:@"injectTest" withInstance:[NSArray array]];
	[injector injectDependenciesTo:testObject];
	XCTAssertNil(testObject.injectTest);
}

- (void)testNothingInjected {
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	XCTAssertNil(testObject.injectTest);
}

- (void)testInjectorPropertyMissing {
	[injector registerProperty:@"foobar" withInstance:@"testString"];
	[injector injectDependenciesTo:testObject];
	XCTAssertNil(testObject.injectTest);
}

- (void)testInjectOnlyNil {
	testObject.injectTest = @"Test";

	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector injectDependenciesTo:testObject];

	XCTAssertEqual(testObject.injectTest, @"Test");
}

- (void)testDidInjectDependencies {
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector injectDependenciesTo:testObject];
	XCTAssertTrue(testObject.didInject);
}


- (void)testNotDidInjectDependencies {
	testObject.injectTest = @"Test";
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector injectDependenciesTo:testObject];
	XCTAssertFalse(testObject.didInject);
}

- (void)testRegisterTwice {
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector registerProperty:@"injectTest" withInstance:@"secondString"];
	[injector injectDependenciesTo:testObject];
	XCTAssertEqual(testObject.injectTest, @"testString");
}


- (void)testRegisterTwice_add_propery_only_once {
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector registerProperty:@"injectTest" withInstance:@"secondString"];
	[injector injectDependenciesTo:testObject];

	XCTAssertEqual(injector.registeredProperties.count, 1);
}

- (void)testInstanceForProperty {
	NSString *instance = @"testString";
	[injector registerProperty:@"injectTest" withInstance:instance];

	NSString *instanceForProperty = [injector instanceForProperty:@"injectTest"];
	XCTAssertEqual(instanceForProperty, instance);
}


- (void)testDeletePropertyWithName {
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector deleteProperty:@"injectTest"];


	NSString *instanceForProperty = [injector instanceForProperty:@"injectTest"];
	XCTAssertNil(instanceForProperty);
	XCTAssertEqual(injector.registeredProperties.count, 0);

}

@end
