#import <Kiwi/Kiwi.h>
// Class under test
#import "OSPSessionActor.h"

#import "OSPActorSystemMock.h"
#import "OSPTwitterLoginActor.h"
#import "OSPromiseMatcher.h"
#import <Oscar/OSActors.h>

SPEC_BEGIN(OSPSessionActorTest)
registerMatchers(@"OS");

describe(@"OSPSessionActor", ^{
    OSMainActorSystem *actorSystem = actorSystemMock();
    __block OSPSessionActor *sut;
    __block OSActorRef *sutRef;
    OSActorRef *twitterLoginActor = [OSActorRef mock];

    beforeAll(^{
        [actorSystem stub:@selector(actorOfClass:caller:) andReturn:twitterLoginActor withArguments:[OSPTwitterLoginActor class], any()];
        sut = [[OSPSessionActor alloc] initWithActorSystem:actorSystem];
        sutRef = [[OSActorRef alloc] initWithActor:sut caller:self];
    });
    
    context(@"login", ^{
        OSPLogin *login = [OSPLogin new];

        it(@"should send login message to twitter actor", ^{
            [[twitterLoginActor shouldEventually] receive:@selector(ask:) andReturn:[RXPromise new]];
            [sutRef ask:login];            
            KWCaptureSpy *spy = [twitterLoginActor captureArgument:@selector(ask:) atIndex:0];
            [[expectFutureValue(spy.argument) shouldEventually] beKindOfClass:[OSPTwitterLogin class]];
        });
        
        context(@"twitter actor succeeded", ^{
            OSPTwitterUser *twitterUser = [[OSPTwitterUser alloc] initWithName:@"test"];
            
            beforeAll(^{
                RXPromise *successPromise = [RXPromise new];
                [successPromise resolveWithResult:twitterUser];
                [twitterLoginActor stub:@selector(ask:) andReturn:successPromise];
            });
            
            pending_(@"store user", ^{
                
            });
            
            it(@"return succeeded result with user", ^{
                RXPromise *result = [sutRef ask:login];
                [result wait];
                [[result should] beFulfilled];
                [[[result.get name] should] equal:twitterUser.name];
            });
        });        
    });
    
    context(@"logout", ^{
       pending_(@"should clear user storage", ^{
           
       });
    });
});
SPEC_END
