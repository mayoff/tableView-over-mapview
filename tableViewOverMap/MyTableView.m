//
//  MyTableView.m
//  tableViewOverMap
//
//  Created by Rob Mayoff on 8/27/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "MyTableView.h"

@implementation MyTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return point.y >= 0 && [super pointInside:point withEvent:event];
}

@end
