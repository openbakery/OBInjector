//
//
// Author: René Pirringer
//
//

#import "OBInjectorController.h"
#import "OBInjector.h"

@interface OBInjector(Private)
- (instancetype)initPrivate;
@end


@implementation OBInjectorController {
	OBInjector *_injector;
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
		_injector = [[OBInjector alloc] initPrivate];
	}
	return self;
}


- (OBInjector *)injector {
	return _injector;
}



@end