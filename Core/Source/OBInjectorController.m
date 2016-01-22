//
//
// Author: René Pirringer
//
//

#import "OBInjectorController.h"
#import "OBPropertyInjector.h"


@implementation OBInjectorController {
	OBPropertyInjector *_injector;
}


+ (OBInjectorController *)sharedController {
	static OBInjectorController *sharedController = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
			sharedController = [[OBInjectorController alloc] init];
	});
	return sharedController;
}

+ (void)injectDependenciesTo:(NSObject *)injectTo {
	[[OBInjectorController sharedController].injector injectDependenciesTo:injectTo];
}


- (instancetype)init {
	self = [super init];
	if (self) {
	}
	return self;
}


+ (void)configureInjector:(OBInjectorConfigureInjectorBlock)block {
	[[OBInjectorController sharedController] configureInjector:block];
}


- (void)configureInjector:(OBInjectorConfigureInjectorBlock)block {
	if (!_injector) {
		if (block) {
			_injector = [[OBPropertyInjector alloc] init];
			block(_injector);
		}
	}
}

- (OBPropertyInjector *)injector {
	return _injector;
}



@end