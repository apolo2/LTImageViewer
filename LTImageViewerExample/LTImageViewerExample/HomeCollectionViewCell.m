//
//  HomeCollectionViewCell.m
//  LTImageViewerExample
//
//  Created by Le Thang on 3/11/16.
//  Copyright © 2016 Le Thang. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeCollectionViewCell ()

@end

@implementation HomeCollectionViewCell

+ (UINib*) nib {
    return [UINib nibWithNibName:[self nibName] bundle:[NSBundle mainBundle]];
}

+ (NSString*) nibName {
    return NSStringFromClass([self class]);
}

- (void) configCellWithImageURL:(NSString*)imageURL {
    [self.imgPhoto setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
    }];
}

@end