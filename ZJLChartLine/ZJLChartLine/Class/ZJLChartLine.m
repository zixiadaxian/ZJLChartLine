//
//  ZJLChartLine.m
//  ZJLChartLine
//
//  Created by HiPal on 16/4/5.
//  Copyright © 2016年 Hipal. All rights reserved.
//

#import "ZJLChartLine.h"
#import "UIBezierPath+Granularity.h"
static const CGFloat chart_X_Y_Label                = 50.f; //X Y  label高度
static const CGFloat chartLine_To_Top_Span          = 30.f; // 距离顶部高度 右边
static const CGFloat chartLine_To_Line_Span         = 70.0; // X 网格间距

#define kRandomColor [UIColor colorWithRed:((arc4random() % 255 )/ 255) green:((arc4random() % 255) / 255) blue:((arc4random() % 255) / 255) alpha:1.00f]

@interface ZJLChartLine ()

@property (nonatomic, weak) id<ZJLChartDataSource>dataSource;

@property (nonatomic  ,strong) NSMutableArray   *yValues;
@property (nonatomic  ,strong) NSArray          *xLabels;
@property (nonatomic  ,assign) CGFloat          yMax;
@property (nonatomic  ,assign) NSInteger        yLineCount;
@property (nonatomic  ,strong) UIScrollView     *scrollView;
@property (nonatomic  ,strong) UIView           *lineView;
@end


@implementation ZJLChartLine
{
    CGRect _viewFrame;
}
- (instancetype)initWithFrame:(CGRect)frame withDataSource:(id<ZJLChartDataSource>)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor grayColor];
        
        self.dataSource = dataSource;
        
        _viewFrame = frame;
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(zjlChartLineYMaxValue:)]) {
            _yMax = [self.dataSource zjlChartLineYMaxValue:self];
        }
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(zjlChartLineYValues:)]) {
            _yValues = [self.dataSource zjlChartLineYValues:self];
        }
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(zjlChartLineXLabel:)]) {
            _xLabels = [self.dataSource zjlChartLineXLabel:self];
        }
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(zjlChartLineYCount:)]) {
            _yLineCount = [self.dataSource zjlChartLineYCount:self];
        }
        if (chart_X_Y_Label + chartLine_To_Line_Span * _yLineCount < _viewFrame.size.width) {
            self.scrollView.contentSize = CGSizeMake(_viewFrame.size.width , 0);
        }else{
            self.scrollView.contentSize = CGSizeMake(chart_X_Y_Label + chartLine_To_Line_Span * (_xLabels.count-1)+chartLine_To_Top_Span , 0);
        }
        
    }
    return self;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, chart_X_Y_Label + chartLine_To_Line_Span *( _xLabels.count -1 ), _viewFrame.size.height)];
        [_scrollView addSubview:_lineView];
    }
    return _lineView;
}
/**
 *  添加X轴线
 */
- (void)add_X_Line {
    UIBezierPath * path = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    for (NSInteger i = 0; i <= _yLineCount; i++) {
        
        [path moveToPoint:CGPointMake(chart_X_Y_Label, chartLine_To_Top_Span + ((_viewFrame.size.height -  chart_X_Y_Label-chartLine_To_Top_Span)/_yLineCount )* i)];
        [path addLineToPoint:CGPointMake(chart_X_Y_Label + chartLine_To_Line_Span * (_xLabels.count -1),  chartLine_To_Top_Span + ((_viewFrame.size.height -  chart_X_Y_Label-chartLine_To_Top_Span)/_yLineCount )* i)];
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 0.3f;
        [self.lineView.layer addSublayer:shapeLayer];
    }
}
/**
 *  添加Y轴线
 */
- (void)add_Y_Line {
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    for (NSInteger i = 0; i < _xLabels.count; i++) {
        [path moveToPoint:CGPointMake(chart_X_Y_Label+  chartLine_To_Line_Span*i,chartLine_To_Top_Span)];
        [path addLineToPoint:CGPointMake(chart_X_Y_Label+  chartLine_To_Line_Span*i, _lineView.frame.size.height-chart_X_Y_Label)];
        [path closePath];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
        shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer.lineWidth = 0.3f;
        [self.lineView.layer addSublayer:shapeLayer];
    }
}
/**
 *  添加X标题
 */
- (void)add_X_Label{
    for (int i = 0; i < _xLabels.count; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(chart_X_Y_Label - 5 +chartLine_To_Line_Span*i , _lineView.frame.size.height - chart_X_Y_Label , chartLine_To_Line_Span, chart_X_Y_Label)];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:10.f];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = _xLabels[i];
        [self.lineView addSubview:label];
    }
}
/**
 *  添加Y标题
 */
- (void)add_Y_Label{
    
    CGFloat y_Value = _yMax / _yLineCount ;
    for (NSInteger i = 0; i <= _yLineCount ; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,  ((_lineView.frame.size.height - chartLine_To_Top_Span-chart_X_Y_Label)/ _yLineCount * i), chartLine_To_Line_Span, chart_X_Y_Label)];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:10.f];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%.0f", _yMax - y_Value * i];
        [self.lineView addSubview:label];
    }
}
/**
 *  画线
 */
- (void)drawChartLine {
    
    for (NSMutableArray *yValues in _yValues) {
        
        NSMutableArray *pointX = [NSMutableArray array];
        NSMutableArray *pointY = [NSMutableArray array];
        NSMutableArray *points = [NSMutableArray array];
        
        //X
        for (NSInteger i = 0; i < yValues.count; i++) {
            [pointX addObject:@(chart_X_Y_Label+  chartLine_To_Line_Span*i)];
        }
        //Y
        for (NSInteger i = 0; i < _xLabels.count; i++) {
            [pointY addObject:@(chartLine_To_Top_Span+ _lineView.frame.size.height -chartLine_To_Top_Span- chart_X_Y_Label - ([yValues[i] floatValue] / _yMax )*(_lineView.frame.size.height -chartLine_To_Top_Span- chart_X_Y_Label))];
        }
        //点
        for (NSInteger i = 0; i <pointX.count ; i++) {
            CGPoint point = CGPointMake([pointX[i] floatValue], [pointY[i] floatValue]);
            NSValue * value = [NSValue valueWithCGPoint:point];
            [points addObject:value];
        }
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineWidth = 2.f;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeEnd = 0.f;
        shapeLayer.strokeColor = kRandomColor.CGColor;
        [self.lineView.layer addSublayer:shapeLayer];
        
        UIBezierPath * bezierLine = [UIBezierPath bezierPath];
        for (NSInteger i = 0; i < points.count; i++) {
            CGPoint point = [points[i] CGPointValue];
            if (i == 0) {
                [bezierLine moveToPoint:point];
            } else {
                [bezierLine addLineToPoint:point];
            }
            [self addXLabel:point andIndex:i text:yValues[i]];
        }
        bezierLine =[bezierLine smoothedPathWithGranularity:20];//设置曲线
        shapeLayer.path = bezierLine.CGPath;
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = points.count * 0.5f;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
        pathAnimation.autoreverses = NO;
        [shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        shapeLayer.strokeEnd = 1.f;
    }
}
/**
 *  刷新
 */
- (void)reloadData{

    [self add_X_Line];
    [self add_Y_Line];
    [self add_X_Label];
    [self add_Y_Label];
    [self drawChartLine];
}

//标记x轴label
- (void)addXLabel:(CGPoint)point andIndex:(NSInteger)index text:(NSString *)text{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    view.center = point;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5.f;
    view.layer.masksToBounds = YES;
    [self.lineView addSubview:view];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    label.center = point;
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:10.f];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    [self.lineView addSubview:label];
}

@end
