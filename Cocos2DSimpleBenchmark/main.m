//
//  main.m
//  Cocos2DSimpleBenchmark
//
//  Created by David Wagner on 02/03/2013.
//  Copyright David Wagner 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"AppController");
    [pool release];
    return retVal;
}
