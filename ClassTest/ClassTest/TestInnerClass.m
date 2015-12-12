//
//  TestInnerClass.m
//  ClassTest
//
//  Created by Developer on 13/12/15.
//  Copyright © 2015 Neerav. All rights reserved.
//

#import "TestInnerClass.h"

@implementation TestInnerClass
- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _integer = [aDecoder decodeIntegerForKey:@"integer"];
        _string = [aDecoder decodeObjectForKey:@"string"];
    }
    return self;
}

- (void) printStuff {
    NSLog(@"_integer = %zd", _integer);
    NSLog(@"_string = %@", _string);
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_integer forKey:@"integer"];
    [aCoder encodeObject:_string forKey:@"string"];
}
@end


@implementation TestMiddleClass

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        //_testInnerClass = [aDecoder decodeObjectForKey:@"TestInnerClass"];
        [self loadTestInnerClass];
    }
    return self;
}

- (void) printStuff {
    NSLog(@"_testInnerClass = %@, _testInnerClass.string = %@, _testInnerClass.integer = %zd", _testInnerClass, _testInnerClass.string, _testInnerClass.integer);
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_testInnerClass forKey:@"TestInnerClass"];
}

- (void) loadTestInnerClass {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"TestInnerClass"];
    if (data != nil) {
        _testInnerClass = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }else{
        _testInnerClass = [[TestInnerClass alloc] init];
    }
}

- (void) saveTestInnerClass {
    NSData *serialized = [NSKeyedArchiver archivedDataWithRootObject:_testInnerClass];
    [[NSUserDefaults standardUserDefaults] setObject:serialized forKey:@"TestInnerClass"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) save {
    [self saveTestInnerClass];
}

@end

@interface TestClass()
@property (strong, nonatomic) TestMiddleClass *testMiddleClass;
@end

@implementation TestClass

- (id) init{
    if (self = [super init]) {
        [self loadTestMiddleClass];
    }
    return self;
}

- (void) loadTestMiddleClass {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"TestMiddleClass"];
    if (data != nil) {
        _testMiddleClass = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }else{
        _testMiddleClass = [[TestMiddleClass alloc] init];
    }
}

- (void) saveTestMiddleClass {
    [_testMiddleClass save];
    NSData *serialized = [NSKeyedArchiver archivedDataWithRootObject:_testMiddleClass];
    [[NSUserDefaults standardUserDefaults] setObject:serialized forKey:@"TestMiddleClass"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) save {
    [self saveTestMiddleClass];
}

//
- (TestMiddleClass *)getTestMiddleClass {
    return _testMiddleClass;
}

- (TestInnerClass *)getTestInnerClass {
    return _testMiddleClass.testInnerClass;
}

- (NSInteger) getInnerIntiger {
    return _testMiddleClass.testInnerClass.integer;
}

- (NSString *) getInnerString{
    return _testMiddleClass.testInnerClass.string;
}

- (void) printStuff {
    NSLog(@"self = %@ _testMiddleClass = %@, testInnerClass = %@, integer = %zd, string = %@", self, self.testMiddleClass, _testMiddleClass.testInnerClass, _testMiddleClass.testInnerClass.integer, _testMiddleClass.testInnerClass.string);
}


@end