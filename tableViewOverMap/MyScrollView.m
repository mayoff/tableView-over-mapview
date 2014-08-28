//
//  MyScrollView.m
//  tableViewOverMap
//
//  Created by Rob Mayoff on 8/28/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    return hitView == self ? nil : hitView;
}

@end
