#import "TestHelper.h"

static NSString
  *foo = @"foo"
, *bar = @"bar"
;

SpecBegin(_AsyncSpecTest)

describe(@"group", ^{
  it(@"example 1", ^{
    waitUntil(^(DoneCallback done) {
      dispatch_async(dispatch_get_main_queue(), ^{
        assertEqualObjects(foo, @"foo");
        done();
      });
    });
  });

  it(@"example 2", ^{
    waitUntil(^(DoneCallback done) {
      dispatch_async(dispatch_get_main_queue(), ^{
        assertEqualObjects(bar, @"bar");
        done();
      });
    });
  });

  it(@"example 3", ^{
    waitUntil(^(DoneCallback done) {
      dispatch_async(dispatch_get_main_queue(), ^{
        assertFalse(NO);
        done();
      });
    });
  });
});

SpecEnd

@interface AsyncSpecTest : XCTestCase; @end
@implementation AsyncSpecTest

- (void)testAsyncSpec {
  foo = @"not foo";
  bar = @"not bar";
  XCTestRun *result = RunSpec(_AsyncSpecTestSpec);
  assertEqual([result unexpectedExceptionCount], 0);
  assertEqual([result failureCount], 2);
  assertFalse([result hasSucceeded]);
  foo = @"foo";
  bar = @"bar";
}

@end
