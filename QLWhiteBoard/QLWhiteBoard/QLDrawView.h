//
//  QLDrawView.h
//  TeacherA
//
//  Created by MQL-IT on 2017/6/5.
//  Copyright © 2017年 Joky Lee. All rights reserved.
//  高性能画板

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QLDrawingMode) {
    QLDrawingMode_Draw, //绘画
    QLDrawingMode_Earse, //擦除
    QLDrawingMode_None, //无操作
};

@interface QLDrawView : UIView
/// 模式 绘画/擦除
@property (nonatomic, assign) QLDrawingMode drawingMode;
/// 清屏
- (void)clearScreen;
@end
