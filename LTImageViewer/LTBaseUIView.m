//
//  LTBaseUIView.m
//  LTImageViewerExample
//
//  Created by Le Thang on 3/12/16.
//  Copyright © 2016 Le Thang. All rights reserved.
//

#import "LTBaseUIView.h"

@implementation LTBaseUIView

+ (NSString*) nibName {
    NSString *name = NSStringFromClass([self class]);
    return name;
}

+ (id) initViewUsingNib {
    UIViewController *tmpVC = [[UIViewController alloc] initWithNibName:[self nibName] bundle:[NSBundle mainBundle]];
    return tmpVC.view;
}

@end
