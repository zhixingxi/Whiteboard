//
//  QLDrawView.m
//  TeacherA
//
//  Created by MQL-IT on 2017/6/5.
//  Copyright © 2017年 Joky Lee. All rights reserved.
//

#import "QLDrawView.h"

static CGFloat line_width = 3.0;

@interface QLDrawView ()
/// 线条数组
@property (nonatomic, strong) NSMutableArray * lines;
/// 线条颜色, 默认黑
@property (nonatomic, strong) UIColor *lineColor;
/// 线条宽度, 默认3.0
@property (nonatomic, assign) CGFloat lineWidth;
/// 贝塞尔曲线
@property (nonatomic, strong) UIBezierPath *bezierPath;
/// 模式, 目前没有任何作用
@property (nonatomic, assign) CGBlendMode kBlendMode;
/// 展示层
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
    
@end

@implementation QLDrawView


#pragma mark ******** LifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.drawingMode = QLDrawingMode_None;
    }
    return self;
}
#pragma mark ******** public method
/// 清屏
- (void)clearScreen
{
    if (!self.lines.count) {
        return ;
    }
    [self.lines makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [[self mutableArrayValueForKey:@"lines"] removeAllObjects];
}

#pragma mark ******** System Delegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint startP = [self pointWithTouchs:touches];
    if ([event allTouches].count == 1) {
        UIBezierPath *path = [self paintPathWithLineWidth:_lineWidth startPoint:startP];
        _bezierPath = path;
        CAShapeLayer *slayer = [CAShapeLayer layer];// 性能更好
        slayer.path = path.CGPath;
        slayer.backgroundColor = [UIColor clearColor].CGColor;
        slayer.fillColor = [UIColor clearColor].CGColor;
        slayer.lineCap = kCALineCapRound;
        slayer.lineJoin = kCALineJoinRound;
        slayer.strokeColor = self.lineColor.CGColor;
        slayer.lineWidth = path.lineWidth;
        [self.layer addSublayer:slayer];
        _shapeLayer = slayer;
        [[self mutableArrayValueForKey:@"lines"] addObject:_shapeLayer];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获取移动点
    CGPoint moveP = [self pointWithTouchs:touches];
    if ([event allTouches].count > 1) {
        [self.superview touchesMoved:touches withEvent:event];
    } else if ([event allTouches].count == 1) {
        [_bezierPath addLineToPoint:moveP];
        _shapeLayer.path = _bezierPath.CGPath;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([event allTouches].count > 1){
        [self.superview touchesMoved:touches withEvent:event];
    }
}


#pragma mark ******** private
-(UIBezierPath * )paintPathWithLineWidth:(CGFloat)width startPoint:(CGPoint)startP {
    UIBezierPath *path = [[UIBezierPath alloc]init];
    path.lineWidth = width;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    [path moveToPoint:startP];
    return path;
}

- (CGPoint )pointWithTouchs:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

#pragma mark ******** set / get
- (void)setDrawingMode:(QLDrawingMode)drawingMode {
    _drawingMode = drawingMode;
    switch (drawingMode) {
        case QLDrawingMode_Draw:
        {// 绘图
            self.lineWidth = line_width;
            self.lineColor = [UIColor blackColor];
            self.kBlendMode = kCGBlendModeNormal;
            break;
        }
        case QLDrawingMode_Earse:
        {// 擦除
            self.lineWidth = line_width * 3;
            self.lineColor = self.backgroundColor;
            self.kBlendMode = kCGBlendModeDestinationIn;
            break;
        }
        case QLDrawingMode_None:
        {// 无操作
            self.lineWidth = line_width * 0;
            self.lineColor = [UIColor clearColor];
            break;
        }
            
        default:
            break;
    }
    
    
}

- (NSMutableArray *)lines {
    if (!_lines) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}










@end
