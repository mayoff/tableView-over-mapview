//
//  ScrollContentView.m
//  tableViewOverMap
//
//  Created by Rob Mayoff on 8/28/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "ScrollContentView.h"

static const CGFloat kGutterWidth = 30;

@implementation ScrollContentView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    return hitView == self ? nil : hitView;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    // Layout of subviews horizontally:
    // [gutter/2][gutter][subview][gutter][subview][gutter][subview][gutter][gutter/2]
    // where 3 * gutter + subview = width of superview

    CGSize superSize = self.superview.bounds.size;
    CGFloat x = kGutterWidth * 3 / 2;
    CGFloat subWidth = superSize.width - kGutterWidth * 3;

    for (UITableView *subview in self.subviews) {
        subview.frame = CGRectMake(x, 0, subWidth, superSize.height);
        x += subWidth + kGutterWidth;

        CGFloat topInset = superSize.height - subview.rowHeight;
        subview.contentInset = (UIEdgeInsets){ .top = topInset };
        subview.contentOffset = CGPointMake(0, -topInset);
    }

    x += kGutterWidth / 2;
    self.frame = CGRectMake(0, 0, x, superSize.height);
    ((UIScrollView *)self.superview).contentSize = self.bounds.size;

    _pageWidth = subWidth + kGutterWidth;
}

@end
