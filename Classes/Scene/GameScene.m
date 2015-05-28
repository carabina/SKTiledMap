//
//  GameScene.m
//  SKTiledMap
//
//  Created by JasioWoo on 15/4/10.
//  Copyright (c) 2015年 JasioWoo. All rights reserved.
//

#import "GameScene.h"
#import "SKTiledMap.h"


@interface GameScene ()

@property (nonatomic, strong) SKTMMapLayer *mapLayer;

@end


@implementation GameScene {
    BOOL m_contentCreated;
}


- (instancetype)initWithSize:(CGSize)size {
    NSLog(@"GameScene initWithSize = %@", NSStringFromCGSize(size));
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor grayColor];
    }
    
    return self;
}

-(void)didMoveToView:(SKView *)view {
    if (!m_contentCreated) {
        m_contentCreated = YES;
        
        self.mapLayer = [[SKTMMapLayer alloc] initWithContentsOfFile:@"TiledMap/desert.tmx"];
        [self addChild:self.mapLayer];
        
    }
}

#if TARGET_OS_IPHONE
#pragma mark - Event Handling - iOS
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    [self touchIn:touchPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    [self touchMoved:touchPoint];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    [self touchEnd:touchPoint];
}

// phone call or back home screen
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    [self touchEnd:touchPoint];
}

#else

#pragma mark - Event Handling - OS X
-(void)mouseDown:(NSEvent *)theEvent {
    CGPoint location = [theEvent locationInNode:self];
    [self touchIn:location];
}

- (void)mouseDragged:(NSEvent *)theEvent {
    CGPoint location = [theEvent locationInNode:self];
    [self touchMoved:location];
}

- (void)mouseUp:(NSEvent *)theEvent {
    CGPoint location = [theEvent locationInNode:self];
    [self touchEnd:location];
}
#endif

CGPoint lastMovedPoint;
- (void)touchIn:(CGPoint)point {
    lastMovedPoint = point;
}

- (void)touchMoved:(CGPoint)point {
    CGFloat dx = (lastMovedPoint.x - point.x) * 1.;
    CGFloat dy = (lastMovedPoint.y - point.y) * 1.;
//    NSLog(@"%f, %f", dx, dy);
    lastMovedPoint = point;
    self.mapLayer.position = CGPointMake(self.mapLayer.position.x - dx, self.mapLayer.position.y - dy);
}

- (void)touchEnd:(CGPoint)point {
    
}


#pragma mark - Game Loop
- (void)update:(NSTimeInterval)currentTime {
    
}

- (void)didSimulatePhysics {
    
}

- (void)didFinishUpdate {

}


@end