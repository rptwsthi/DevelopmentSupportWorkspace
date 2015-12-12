//
//  TestInnerClass.h
//  ClassTest
//
//  Created by Developer on 13/12/15.
//  Copyright © 2015 Neerav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestInnerClass : NSObject<NSCoding>
@property (assign) NSInteger integer;
@property (assign) NSString * string;
- (void) printStuff;
@end

@interface TestMiddleClass : NSObject<NSCoding>
@property (strong) TestInnerClass *testInnerClass;
- (void) printStuff;
@end


@interface TestClass : NSObject

- (void) save;

- (TestMiddleClass *)getTestMiddleClass;
- (TestInnerClass *)getTestInnerClass;
- (NSInteger) getInnerIntiger;
- (NSString *) getInnerString;

- (void) printStuff;


@end