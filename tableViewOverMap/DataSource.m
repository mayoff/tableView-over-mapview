//
//  DataSource.m
//  tableViewOverMap
//
//  Created by Rob Mayoff on 8/28/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@ item %d", self.prefix, indexPath.row];

    return cell;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat yMin = -scrollView.contentInset.top;
    CGFloat yMax = MIN(0, scrollView.contentSize.height - scrollView.bounds.size.height);
    if (targetContentOffset->y < yMax) {
        if (velocity.y < 0) {
            targetContentOffset->y = yMin;
        } else {
            targetContentOffset->y = yMax;
        }
    }
}

@end
