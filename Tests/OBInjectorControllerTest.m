//
// Created by Rene Pirringer on 22.01.16.
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
//

#import "OBInjector.h"
#import "OBInjectTestObject.h"

@import XCTest;

@interface OBInjectorControllerTest : XCTestCase
@end

@implementation OBInjectorControllerTest {
	OBInjectTestObject *testObject;

}
- (void)setUp {
	[super setUp];
	[[OBInjectorController sharedController] setValue:nil forKey:@"_injector"];
	testObject = [[OBInjectTestObject alloc] init];
}


- (void)testUninitializedController {
	[OBInjectorController injectDependenciesTo:testObject];
	XCTAssertNil(testObject.injectTest);
}


- (void)testInitializedController {
	[OBInjectorController configureInjector:^(OBPropertyInjector *injector) {
			[injector registerProperty:@"injectTest" withInstance:@"testString"];
	}];
	[OBInjectorController injectDependenciesTo:testObject];
	XCTAssertEqual(testObject.injectTest, @"testString");
}


- (void)testConfigureController {
	__block NSInteger count = 0;
	[OBInjectorController configureInjector:^(OBPropertyInjector *injector) {
			count++;
	}];
	[OBInjectorController configureInjector:^(OBPropertyInjector *injector) {
			count++;
	}];
	[OBInjectorController configureInjector:^(OBPropertyInjector *injector) {
			count++;
	}];
	XCTAssertEqual(count, 1);
}
@end
