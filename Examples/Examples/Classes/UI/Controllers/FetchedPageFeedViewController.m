//
// Created by 杨玉刚 on 3/24/16.
// Copyright (c) 2016 奇迹空间. All rights reserved.
//

#import "FetchedPageFeedViewController.h"
#import <StarterKit/SKTableViewControllerBuilder.h>
#import "Feed.h"
#import "SKManagedHTTPSessionManager+Example.h"
#import "SKFeedTableViewCell.h"
#import "SKFeedPictureTableViewCell.h"
#import <libextobjc/EXTScope.h>

@implementation FetchedPageFeedViewController

- (id)init {
  if (self = [super init]) {
    [self createWithBuilder:^(SKTableViewControllerBuilder *builder) {
      builder.cellMetadata = @[[SKFeedTableViewCell class], [SKFeedPictureTableViewCell class]];
      builder.entityName = @"Feed";
      builder.modelOfClass = [Feed class];

      builder.dequeueReusableCellBlock = ^NSString *(Feed *item, NSIndexPath *indexPath) {
        if (item.images && item.images.count > 0) {
          return [SKFeedPictureTableViewCell cellIdentifier];
        }
        return [SKFeedTableViewCell cellIdentifier];
      };

      @weakify(self);
      builder.paginateBlock = ^(NSDictionary *parameters) {
        @strongify(self)
        return [self.httpSessionManager fetchFeeds:parameters];
      };
    }];
  }
  return self;
}

@end