//
// ELO 
//
// Created by rene on 05.07.13.
// Copyright 2013. All rights reserved.
//
// 
//


#import "OBPropertyInjector.h"
#import "OBInjectTestObject.h"
#import "OBInjectorController.h"

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

@interface OBPropertyInjector (Private)
- (instancetype)initPrivate;
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

- (void)testRegisterTwice {
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector registerProperty:@"injectTest" withInstance:@"secondString"];
	[injector injectDependenciesTo:testObject];
	assertThat(testObject.injectTest, is(equalTo(@"testString")));
}

- (void)testInstanceForProperty {
	NSString *instance = @"testString";
	[injector registerProperty:@"injectTest" withInstance:instance];

	NSString *instanceForProperty = [injector instanceForProperty:@"injectTest"];
	assertThat(instanceForProperty, is(instance));
}


- (void)testDeletePropertyWithName {
	[injector registerProperty:@"injectTest" withInstance:@"testString"];
	[injector deleteProperty:@"injectTest"];


	NSString *instanceForProperty = [injector instanceForProperty:@"injectTest"];
	assertThat(instanceForProperty, is(nilValue()));

}

@end