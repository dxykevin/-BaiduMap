//
//  AnnotationDemoViewController.m
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import "ViewController.h"
#import "BMKCircleAnnotationView.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#define KLatitude 36.072517
#define kLongitude 120.376184
@interface ViewController () <BMKMapViewDelegate>
/** 地图视图 */
@property (nonatomic,strong) BMKMapView *mapView;
@end

@implementation ViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    [self initMapView];
    
    
}

- (void)touch {
    
    NSLog(@"touch");
}
/** 初始化地图 */
- (void)initMapView {
    
    self.mapView = [[BMKMapView alloc] init];
    
    /** 市南区 */
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(KLatitude, kLongitude);//原始坐标
    //转换 google地图、soso地图、aliyun地图、mapabc地图和amap地图所用坐标至百度坐标
    NSDictionary* testdic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_COMMON);
    //转换GPS坐标至百度坐标(加密后的坐标)
    testdic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_GPS);
    NSLog(@"x=%@,y=%@",[testdic objectForKey:@"x"],[testdic objectForKey:@"y"]);
    //解密加密后的坐标字典
    CLLocationCoordinate2D baiduCoor = BMKCoorDictionaryDecode(testdic);//转换后的百度坐标
    NSLog(@"%f %f",baiduCoor.latitude,baiduCoor.longitude);
    self.mapView.centerCoordinate = baiduCoor;
    
    self.view = _mapView;
    
    //设置地图缩放级别 此级别显示到行政区
    [_mapView setZoomLevel:14];
    
    [self.mapView setTrafficEnabled:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self addPointAnnotation];
}

/** 添加一个PointAnnotation */
- (void)addPointAnnotation {
    
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(KLatitude, kLongitude);
    annotation.coordinate = coor;
//    annotation.title = @"这里是manor";
//    annotation.subtitle = @"我是副标题";
    [self.mapView addAnnotation:annotation];
}

//// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnimation"];
        annotationView.animatesDrop = YES;
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(0, 0, 80, 80);
        button.center = annotationView.center;
        [button setBackgroundImage:[UIImage imageNamed:@"blue"] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(touch:) forControlEvents:(UIControlEventTouchUpInside)];
        [button setTitle:@"市南区\n333" forState:(UIControlStateNormal)];
        button.titleLabel.numberOfLines = 2;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [annotationView addSubview:button];
        return annotationView;
//        BMKCircleAnnotationView *newAnnotationView = [[BMKCircleAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.pinColor = BMKPinAnnotationColorGreen;
//        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
////        newAnnotationView.userInteractionEnabled = YES;
//        [newAnnotationView.button addTarget:self action:@selector(touch:) forControlEvents:(UIControlEventTouchUpInside)];
//        return newAnnotationView;
    }
    return nil;
}

- (void)touch:(UIButton *)bt {
    
    NSLog(@"%s",__func__);
    [self.mapView removeAnnotations:self.mapView.annotations];
    self.mapView.zoomLevel ++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addPointAnnotation];
    });
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    NSLog(@"%s",__func__);
    [self.mapView removeAnnotations:self.mapView.annotations];
    self.mapView.zoomLevel ++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addPointAnnotation];
    });
}

/**
 *当点击annotation view弹出的泡泡时，调用此接口
 *@param mapView 地图View
 *@param view 泡泡所属的annotation view
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view {
    
    NSLog(@"%s",__func__);
}

- (void)addOverlayView {
    
    BMKCircle *circle = [BMKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(36.072517, 120.376184) radius:1000];
    [self.mapView addOverlay:circle];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}

- (void)dealloc {
    
    if (_mapView) {
        _mapView = nil;
    }
}

/**
 *地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
 *@param mapview 地图View
 *@param status 此时地图的状态
 */
- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus *)status {
    
//    NSLog(@"%s",__func__);
}

/**
 *点中覆盖物后会回调此接口，目前只支持点中BMKPolylineView时回调
 *@param mapview 地图View
 *@param overlayView 覆盖物view信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedBMKOverlayView:(BMKOverlayView *)overlayView {
    
    NSLog(@"%s",__func__);
}
@end
