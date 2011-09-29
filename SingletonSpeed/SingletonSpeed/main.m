//
//  main.m
//  SingletonSpeed
//
//  Created by BJ Homer on 9/29/11.
//  Copyright (c) 2011 Instructure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject
+ (id)synchronizedInstance;
+ (id)dispatchOnceInstance;
@end

static id synchronizedVar = nil;
static id dispatchVar = nil;

@implementation Test

+ (id)synchronizedInstance {
	@synchronized(self) {
		if (!synchronizedVar) {
			synchronizedVar = [[Test alloc] init];
		}
	}
	return synchronizedVar;
}

+ (id)dispatchOnceInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		dispatchVar = [[Test alloc] init];
	});
	return dispatchVar;
}

@end

#define ITERATIONS 10000000

CFTimeInterval singleThreadedSynchronized(void);
CFTimeInterval singleThreadedSynchronized(void) {
	CFAbsoluteTime start =  CFAbsoluteTimeGetCurrent();
	
	for (int i=0; i<ITERATIONS; ++i) {
		[Test synchronizedInstance];
	}
	CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
	return end - start;
}

CFTimeInterval singleThreadedDispatch(void);
CFTimeInterval singleThreadedDispatch(void) {
	CFAbsoluteTime start =  CFAbsoluteTimeGetCurrent();
	
	for (int i=0; i<ITERATIONS; ++i) {
		[Test dispatchOnceInstance];
	}
	CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
	return end - start;
}

CFTimeInterval multiThreadedSynchronized(void);
CFTimeInterval multiThreadedSynchronized(void) {
	CFAbsoluteTime start =  CFAbsoluteTimeGetCurrent();
	
	int numTasks = 10;
	dispatch_group_t group = dispatch_group_create();
	for (int i=0; i<numTasks; ++i) {
		dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			for (int i=0; i<ITERATIONS/numTasks; ++i) {
				[Test synchronizedInstance];
			}
		});
	}
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	
	CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
	return end - start;
}

CFTimeInterval multiThreadedDispatch(void);
CFTimeInterval multiThreadedDispatch(void) {
	CFAbsoluteTime start =  CFAbsoluteTimeGetCurrent();
	
	int numTasks = 10;
	dispatch_group_t group = dispatch_group_create();
	for (int i=0; i<numTasks; ++i) {
		dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
			for (int i=0; i<ITERATIONS/numTasks; ++i) {
				[Test dispatchOnceInstance];
			}
		});
	}
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	
	CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
	return end - start;
}

int main (int argc, const char * argv[])
{

	@autoreleasepool {
	    
		CFTimeInterval a = singleThreadedSynchronized();
		CFTimeInterval b = singleThreadedDispatch();
		CFTimeInterval c = multiThreadedSynchronized();
		CFTimeInterval d = multiThreadedDispatch();
		
		NSLog(@"\n"
			  @"Single threaded results\n"
			  @"-----------------------\n"
			  @"  @synchronized: %0.4f seconds\n"
			  @"  dispatch_once: %0.4f seconds\n"
			  @"\n"
			  @"Multi threaded results\n"
			  @"----------------------\n"
			  @"  @synchronized: %0.4f seconds\n"
			  @"  dispatch_once: %0.4f seconds\n",
			  a, b, c, d);
		
	    
	}
    return 0;
}

