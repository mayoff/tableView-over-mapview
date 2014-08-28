//
//  ViewController.m
//  tableViewOverMap
//
//  Created by Rob Mayoff on 8/27/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ViewController.h"
#import "MyTableView.h"
#import "ScrollContentView.h"
#import "MyScrollView.h"
#import "DataSource.h"
#import <tgmath.h>

@interface ViewController () <UIScrollViewDelegate>

@end

@implementation ViewController {
    NSMutableArray *dataSources; // need to keep strong references to these because table views don't
    ScrollContentView *contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSources = [NSMutableArray array];
    [self initMapView];
    [self initScrollView];
}

- (void)initMapView {
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:mapView];
}

- (void)initScrollView {
    MyScrollView *scrollView = [[MyScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:scrollView];

    contentView = [[ScrollContentView alloc] init];
    [scrollView addSubview:contentView];
    scrollView.delegate = self;

    [contentView addSubview:[self newTableViewWithPrefix:@"First List" numberOfRows:4]];
    [contentView addSubview:[self newTableViewWithPrefix:@"Second List" numberOfRows:20]];
    [contentView addSubview:[self newTableViewWithPrefix:@"Third List" numberOfRows:10]];
    [contentView addSubview:[self newTableViewWithPrefix:@"Fourth List" numberOfRows:15]];
}

- (MyTableView *)newTableViewWithPrefix:(NSString *)prefix numberOfRows:(NSInteger)numberOfRows {
    DataSource *dataSource = [[DataSource alloc] init];
    dataSource.prefix = prefix;
    dataSource.numberOfRows = numberOfRows;
    [dataSources addObject:dataSource];

    MyTableView *tableView = [[MyTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = dataSource;
    tableView.delegate = dataSource;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.decelerationRate = UIScrollViewDecelerationRateFast;
    tableView.rowHeight = 44;
    return tableView;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat pageWidth = contentView.pageWidth;

    // Force scroll view to stop on a page boundary.
    CGFloat pageNumber = targetContentOffset->x / pageWidth;
    if (velocity.x < 0) {
        pageNumber = floor(pageNumber);
    } else {
        pageNumber = ceil(pageNumber);
    }
    pageNumber = MAX(0, MIN(pageNumber, contentView.subviews.count - 1));
    targetContentOffset->x = pageNumber * pageWidth;
}

@end
