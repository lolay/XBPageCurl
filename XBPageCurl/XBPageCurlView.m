//
//  XBPageCurlView.m
//  XBPageCurl
//
//  Created by xiss burg on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XBPageCurlView.h"

#define kDuration 1


@implementation XBPageCurlView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


#pragma mark - Touch handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint p = [[touches anyObject] locationInView:self];
    p.y = self.bounds.size.height - p.y;
    startPickingPosition.x = self.bounds.size.width;
    startPickingPosition.y = p.y;
    
    [self setCylinderPosition:p animatedWithDuration:kDuration];
    
    CGPoint dir = CGPointMake(startPickingPosition.x-p.x, startPickingPosition.y-p.y);
    dir = CGPointMake(-dir.y, dir.x);
    CGFloat length = sqrtf(dir.x*dir.x + dir.y*dir.y);
    dir.x /= length, dir.y /= length;
    CGFloat angle = atan2f(dir.y, dir.x);
    
    [self setCylinderAngle:angle animatedWithDuration:kDuration];
    [self setCylinderRadius:16+length/4 animatedWithDuration:kDuration];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    CGPoint p = [[touches anyObject] locationInView:self];
    p.y = self.bounds.size.height - p.y;
    self.cylinderPosition = p;
    CGPoint dir = CGPointMake(startPickingPosition.x-self.cylinderPosition.x, startPickingPosition.y-self.cylinderPosition.y);
    dir = CGPointMake(-dir.y, dir.x);
    CGFloat length = sqrtf(dir.x*dir.x + dir.y*dir.y);
    dir.x /= length, dir.y /= length;
    CGFloat angle = atan2f(dir.y, dir.x);
    
    self.cylinderAngle = angle;
    self.cylinderRadius = 16 + length/4;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}

@end