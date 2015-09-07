# OBInjector

The OBInjector is a very small and simple dependency injector for Objective-C that does property injection.


## Usage

See also the Demo project for details.

### Include into your project 

To use the OBInjector in your project the simples way is to use CocoaPods

Add the following line to you Podspec:


```
pod 'OBInjector', '~> 1.0.1'
```

Use the following import in your code:

```
#import <OBInjector/OBInjector.h>
```

### Set up the injector

Now add the OBInjector instance to your AppDelegate.

```
@implementation AppDelegate {
	OBInjector *_injector;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self configureInjector];
	...
}

- (void)configureInjector {
	_injector = [[OBInjector alloc] init];

	
	// retister add the instances that can be injected

	MyService *myService = [[MyService alloc] init];
	[_injector registerProperty:@"myService" withInstance:myService];

  ...

}
```

### Use the injector

The injector is now ready and we want to inject the MyService instance into our ViewController. For this we need to specfiy the property in the ViewController class:


```
@property(nonatomic, strong) MyService *myService;
```

If this property is in the public header or in a private category does't matter.

The last set is to tell the injector that it should inject the dependencies to the ViewController. The pattern for this is that, always the creater of in instance is responsible for triggering the injector.
In this case the ViewController is the root view controller, therefor the AppDelegate is responsible for this, so we add the following code to the `- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {` method:

```	
[self.injector injectDependenciesTo:self.window.rootViewController];	
```


If the ViewController now creates a new ViewController, or a push segue was defined in the storyboard, the ViewController is now responsible to trigger the injection to the new view controller.

To make this simple there is a category on NSObject that helps here:

```
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	[self injectDependenciesTo:segue.destinationViewController];
}
```

To make this work you need to change your AppDelegate to implement the `OBInjectorApplicationDelegate` protocol and the property `@property (nonatomic, readonly) OBInjector *injector;`

```
@interface AppDelegate : UIResponder <OBInjectorApplicationDelegate>
...
@end
```

```
@interface AppDelegate : UIResponder <OBInjectorApplicationDelegate>
...
@end
```

```
- (OBInjector *)injector {
	return _injector;
}
```


### How it works

When the injector is triggered to inject properties to a given class that, all properties of the given class are checked if it matches a registerd propererty. 
Matches mean that the property name must be equal to the registerd property name, and also the class of the property must match.

e.g. 

The injector is configured like this:

```
MyService *myService = [[MyService alloc] init];
[_injector registerProperty:@"myService" withInstance:myService];
```

Now you need to have a class with a property with the name 'myService' of the type 'MyService' so that the instance can be injected:



[_injector injectDependenciesTo:myInstance]

```
@property(nonatomic, strong) MyService *myService;
```

This does not work:
```
@property(nonatomic, strong) MyService *service;
```


__Note:__ Only properties are set when they are nil!

e.g.

```
viewController.myService = [[MySpecialService alloc] init];
[_injector injectDependenciesTo:viewController];
```
Here the propery myServices is not changed!!!

### When do I know that the properties where injected.

If your class implements the protocol `OBInjectorDelegate` and the method `- (void)didInjectDependencies;` then this method is called if the injection is finished, but only if something was injected.


### I want to inject always a new instance


For this you can register a property that calls a block that can create the instance:

```
[_injector registerProperty:@"currentDate" withBlock:^{
	return [NSDate date];
}];
```

If you now have a property `@property(nonatomic, strong) NSDate *currentDate;` you will always have new NSDate instance set when the property is injected.



## Build and test

To build the project run './gradlew xcodebuild' and to run the unit tests './gradlew test'. You need to have Java installed.