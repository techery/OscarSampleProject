#import <Kiwi/Kiwi.h>
// Class under test
#import "OSPSessionActor.h"

#import "OSPActorSystemMock.h"
#import "OSPTwitterLoginActor.h"
#import <Oscar/OSActors.h>

SPEC_BEGIN(OSPSessionActorTest)
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
            [[twitterLoginActor shouldEventually] receive:@selector(ask:)];
            [sutRef ask:login];            
            KWCaptureSpy *spy = [twitterLoginActor captureArgument:@selector(ask:) atIndex:0];
            [[expectFutureValue(spy.argument) shouldEventually] beKindOfClass:[OSPTwitterLogin class]];
        });
    });
    
    context(@"logout", ^{
       pending_(@"should clear user storage", ^{
           
       });
    });
});
SPEC_END
