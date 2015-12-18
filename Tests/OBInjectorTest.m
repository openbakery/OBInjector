//
// ELO 
//
// Created by rene on 05.07.13.
// Copyright 2013. All rights reserved.
//
// 
//


#import "OBInjector.h"
#import "OBInjectTestObject.h"
#import "OBInjectorController.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

@interface OBInjector(Private)
- (instancetype)initPrivate;
@end

@interface OBInjectorTest : XCTestCase

@end

@implementation OBInjectorTest
{
	OBInjector *injector;
	OBInjectTestObject *testObject;
}

- (void)setUp {
	[super setUp];
	injector = [[OBInjector alloc] initPrivate];
	testObject = [[OBInjectTestObject alloc] init];
}


- (void)testInjector {
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector injectDependenciesTo:testObject];
	assertThat(testObject.injectTest, is(equalTo(@"testString")));
}

- (void)testInjectorWithWrongClass {
	[injector registerProperty:@"injectTest" withInstance:[NSArray array]];
	[injector injectDependenciesTo:testObject];
	assertThat(testObject.injectTest, is(nilValue()));
}

- (void)testNothingInjected {
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	assertThat(testObject.injectTest, is(nilValue()));
}

- (void)testInjectorPropertyMissing {
	[injector registerProperty:@"foobar" withInstance:@"testString"];
	[injector injectDependenciesTo:testObject];
	assertThat(testObject.injectTest, is(nilValue()));
}

- (void)testInjectOnlyNil {
	testObject.injectTest = @"Test";

	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector injectDependenciesTo:testObject];

	assertThat(testObject.injectTest, is(@"Test"));
}

- (void)testDidInjectDependencies {
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector injectDependenciesTo:testObject];
	assertThatBool(testObject.didInject, is(@YES));
}


- (void)testNotDidInjectDependencies {
	testObject.injectTest = @"Test";
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector injectDependenciesTo:testObject];
	assertThatBool(testObject.didInject, is(@NO));
}

@end