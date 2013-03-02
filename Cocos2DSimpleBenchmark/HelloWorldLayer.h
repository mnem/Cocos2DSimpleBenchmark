//
//  HelloWorldLayer.h
//  Cocos2DSimpleBenchmark
//
//  Created by David Wagner on 02/03/2013.
//  Copyright David Wagner 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCTouchDelegateProtocol.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <CCTouchOneByOneDelegate>
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
