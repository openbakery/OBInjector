[![Build Status](https://travis-ci.org/openbakery/OBInjector.svg?branch=master)](https://travis-ci.org/openbakery/OBInjector)

# OBInjector

The OBInjector is a very small and simple dependency injector for Objective-C that does property injection.


## Usage

See also the Demo project for details.

### Include into your project 

To use the OBInjector in your project the simples way is to use CocoaPods

Add the following line to you Podspec:


```
pod 'OBInjector', '~> 1.4.0'
```

Use the following import in your code:


```
#import <OBInjector/OBInjector.h>
```

### Set up the injector

Now add the OBInjector instance to your AppDelegate.

```

@implementation AppDelegate {
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[OBInjectorController configureInjector:^(OBPropertyInjector *injector) {
		MyService *myService = [[MyService alloc] init];
		[injector registerProperty:@"myService" withInstance:myService];
	}];
}

```

### Use the injector

The injector is now ready and we want to inject the MyService instance into our ViewController. For this we need to specify the property in the ViewController class:


```
@property(nonatomic, strong) MyService *myService;
```

If this property is in the public header or in a private category does't matter.

The last thing is to tell the injector that it should inject the dependencies to the ViewController. The pattern for this is that always the creater of an instance is responsible for triggering the injector.
In this case the ViewController is the root view controller, therefor the AppDelegate is responsible for tiggering the injection, so we add the following code to the `- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {` method:

```	
[OBInjectorController injectDependenciesTo:self.window.rootViewController];	
```


If the ViewController now creates another view controller, or there is a segue in the storyboard that displays a child view controller, the ViewController is now responsible to trigger the injection to the new view controller.

To make this simple there is a category on NSObject that helps here:

```
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	[OBInjectorController injectDependenciesTo:segue.destinationViewController];
}
```


### How it works

When the injector is triggered to inject properties to a given class, all properties of the given class are checked if it matches a registered property. 
Matches mean that the property name must be equal to the registered property name, and also the class of the property must match.

The injector is configured like this:

```
[OBInjectorController configureInjector:^(OBPropertyInjector *injector) {
		MyService *myService = [[MyService alloc] init];
		[injector registerProperty:@“myService” withInstance:myService];
	}];
```

It is made sure that the configureInjector is only called once.

Now you need to have a class with a property with the name 'myService' of the type 'MyService' so that the instance can be injected:


[OBInjectorController injectDependenciesTo:myInstance]

```
@property(nonatomic, strong) MyService *myService;
```

This does __NOT__ work:
```
@property(nonatomic, strong) MyService *service;
```


#### Subclasses

The class type of the injected property must not be exactly the same class. It can be a subclass:

```
MyExtendedService *myService = [[MyExtendedService alloc] init]; // is subclass of MyService
[injector registerProperty:@"myService" withInstance:MyExtendedService]; 
```


#### Protocol

Also a protocol can be registered for injection:

```
@protocol FooService <NSObject>
...
@end
```
```
@interface FooServiceImpl : NSObject <FooService>
...
@end
```

```
FooServiceImpl *fooService = [[FooServiceImpl alloc] init];
[injector registerProperty:@"fooService" withInstance:fooService]; 
```


If you now specify following property the FooServiceImpl gets injected:

```
@protocol (nonatomic, strong) NSObject<FooService> fooService;
```


### Only properties are injected when they are nil


```
viewController.myService = [[MySpecialService alloc] init];
[injector injectDependenciesTo:viewController];
```

Here the propery myServices is not changed!!!


### How do I know that the properties was injected.

If your class implements the protocol `OBInjectorDelegate` and the method `- (void)didInjectDependencies;` then this method is called if the injection is finished, but only if something was injected.

You can use this to finish the initialization for you instance when you need the injected dependencies for this.

### I want to inject always a new instance


For this you can register a property that calls a block that can create the instance:

```
[injector registerProperty:@"currentDate" withBlock:^{
	return [NSDate date];
}];
```

If you now have a property `@property(nonatomic, strong) NSDate *currentDate;` you will always have new NSDate instance set when the property is injected.

## Api Documenation

Here you find the Api documentation generated by AppleDoc:

[http://openbakery.org/documentation/OBInjector/index.html](http://openbakery.org/documentation/OBInjector/index.html)

## Build and test

To build the project run './gradlew xcodebuild' and to run the unit tests './gradlew test'. You need to have Java installed.