//
// Created by Rene Pirringer on 22.01.16.
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
//

#import "OBInjector.h"
#import "OBInjectTestObject.h"

@import XCTest;
@import OCMockito;
@import OCHamcrest;

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
	assertThat(testObject.injectTest, is(nilValue()));
}


- (void)testInitializedController {
	[OBInjectorController configureInjector:^(OBPropertyInjector *injector) {
			[injector registerProperty:@"injectTest" withInstance:@"testString"];
	}];
	[OBInjectorController injectDependenciesTo:testObject];
	assertThat(testObject.injectTest, is(equalTo(@"testString")));
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
	assertThatInteger(count, is(@1));
}
@end
