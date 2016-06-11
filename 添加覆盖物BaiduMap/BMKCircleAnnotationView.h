//
//  BMKCircleAnnotationView.h
//  添加覆盖物BaiduMap
//
//  Created by dxykevin on 16/6/10.
//  Copyright © 2016年 Kevin. All rights reserved.
//
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface BMKCircleAnnotationView : BMKPinAnnotationView
/** 圆形Label */
@property (nonatomic,strong) UIButton *button;

@end
