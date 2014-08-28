//
//  DataSource.h
//  tableViewOverMap
//
//  Created by Rob Mayoff on 8/28/14.
//  Copyright (c) 2014 Rob Mayoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSString *prefix;
@property (nonatomic) NSInteger numberOfRows;

@end
