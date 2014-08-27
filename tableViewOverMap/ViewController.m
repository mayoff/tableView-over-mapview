//
//  ViewController.m
//  tableViewOverMap
//
//  Created by Rob Mayoff on 8/27/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import "ViewController.h"
#import "MyTableView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 44;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = (UIEdgeInsets){ .top = self.tableView.bounds.size.height - self.tableView.rowHeight };
    self.tableView.contentOffset = CGPointMake(0, -self.tableView.contentInset.top);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"List item %d", indexPath.row];

    return cell;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat yMin = -self.tableView.contentInset.top;
    CGFloat yMax = MIN(0, self.tableView.contentSize.height - self.tableView.bounds.size.height);
    if (targetContentOffset->y < yMax) {
        if (velocity.y < 0) {
            targetContentOffset->y = yMin;
        } else {
            targetContentOffset->y = yMax;
        }
    }
}

@end
