//
//  BMKCircleAnnotationView.m
//  添加覆盖物BaiduMap
//
//  Created by dxykevin on 16/6/10.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "BMKCircleAnnotationView.h"
#import <UIView+RoundedCorner.h>
#define kLength 80.0
@implementation BMKCircleAnnotationView

- (instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        [self setBounds:CGRectMake(0.f, 0.f, kLength, kLength)];
        self.button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.button.frame = CGRectMake(0, 0, kLength, kLength);
        [self.button setBackgroundImage:[UIImage imageNamed:@"blue"] forState:(UIControlStateNormal)];
        [self.button addTarget:self action:@selector(touch) forControlEvents:(UIControlEventTouchUpInside)];
        [self.button setTitle:@"市南区\n333" forState:(UIControlStateNormal)];
        self.button.titleLabel.numberOfLines = 2;
        self.button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self addSubview:self.button];
//        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, kLength, kLength)];
//        /** 中心点一致 */
//        self.label.center = self.center;
//        self.label.textColor = [UIColor whiteColor];
//        self.label.font = [UIFont systemFontOfSize:17];
//        self.label.numberOfLines = 0;
//        self.label.textAlignment = NSTextAlignmentCenter;
//        self.label.layer.cornerRadius = kLength / 2;
//        self.label.layer.backgroundColor = [UIColor colorWithRed:28 / 255.0 green:62 / 255.0 blue:139 / 255.0 alpha:1].CGColor;
////        self.label.layer.borderColor = [UIColor whiteColor].CGColor;
////        self.label.layer.borderWidth = 5;
//         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//        [self.label addGestureRecognizer:tap];
//        [self addSubview:_label];
//        self.alpha = 0.85;
    }
    return self;
}

- (void)touch {
    
    NSLog(@"lalala");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
