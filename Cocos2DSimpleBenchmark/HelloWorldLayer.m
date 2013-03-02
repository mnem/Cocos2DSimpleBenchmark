//
//  HelloWorldLayer.m
//  Cocos2DSimpleBenchmark
//
//  Created by David Wagner on 02/03/2013.
//  Copyright David Wagner 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

const BOOL ANIMATE = YES;
const int NUM_SPRITES = 500;

@interface HelloWorldLayer ()
@property (nonatomic, strong) CCSpriteBatchNode* spriteBatch;
@property (nonatomic) int spriteCount;
@property (nonatomic, strong) CCLabelTTF* label;
@end

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) setupMovement:(CCSprite*) sprite size:(CGSize) s
{
	// pick a random point and move to it
	CCActionInterval* move = [CCMoveTo actionWithDuration:rand() % 5 + 2 position:ccp( rand() % (int)s.width, rand() % (int)s.height )];
	CCFiniteTimeAction* moveDone = [CCCallBlock actionWithBlock:^{
        [self setupMovement:sprite size:s];
    }];
    [sprite runAction:[CCSequence actions:move, moveDone, nil]];
}


- (void) addSomeSprites
{
    CGSize s = [CCDirector sharedDirector].winSize;
    for(int i = 0; i < NUM_SPRITES; i++)
    {
        // create sprite
        CCSprite* sprite = [CCSprite spriteWithTexture:self.spriteBatch.texture rect:CGRectMake(0, 0, 64, 64)];
        
        // set random position
        [sprite setPosition:ccp( rand() % (int)s.width, rand() % (int)s.height )];

        if (ANIMATE)
        {
            // set continuous scaling
            CCActionInterval* scale_big = [CCScaleBy actionWithDuration:rand() % 2 + 1 scale:2];
            CCActionInterval* scale_big_back = scale_big.reverse;
            CCActionInterval* scale_small = [CCScaleBy actionWithDuration:rand() % 2 + 1 scale:-2];
            CCActionInterval* scale_small_back = scale_small.reverse;
            CCActionInterval* seq_scale = [CCSequence actions:scale_big, scale_big_back, scale_small, scale_small_back, nil];
            [sprite runAction:[CCRepeatForever actionWithAction:seq_scale]];
            
            // set random continuous rotation
            CCActionInterval* rotate = [CCRotateBy actionWithDuration:rand() % 2 + 1 angle:(rand() % 720) - 360];
            [sprite runAction:[CCRepeatForever actionWithAction:rotate]];
            
            // set random continuous movement
            [self setupMovement:sprite size:s];
        }
        
        [self.spriteBatch addChild:sprite];
        
        _spriteCount++;
    }
    
    self.label.string = [NSString stringWithFormat:@"Sprites: %d", _spriteCount];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self addSomeSprites];
    
    return YES;
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        self.label = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:12];
        CGSize s = [CCDirector sharedDirector].winSize;
        self.label.position =  ccp( s.width /2 , s.height/2 );

        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
        self.spriteBatch = [CCSpriteBatchNode batchNodeWithFile:@"blowfish.png" capacity:5000];
        [self addChild:self.spriteBatch];
        
        [self addChild:self.label];
        
        [self registerWithTouchDispatcher];
	}
	return self;
}

@end
