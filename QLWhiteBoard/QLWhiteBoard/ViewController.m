//
//  ViewController.m
//  QLWhiteBoard
//
//  Created by MQL-IT on 2017/6/20.
//  Copyright © 2017年 MQL-IT. All rights reserved.
//

#import "ViewController.h"
#import "QLDrawView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet QLDrawView *drawingView;
@property (weak, nonatomic) IBOutlet UIButton *drawBtn;
@property (weak, nonatomic) IBOutlet UIButton *eraseBtn;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    [self.drawBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
     [self.eraseBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
}
- (IBAction)startDraw:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        self.drawingView.drawingMode = QLDrawingMode_Draw;
    } else {
        self.drawingView.drawingMode = QLDrawingMode_None;
        
    }
    self.eraseBtn.selected = NO;
}

- (IBAction)earse:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        self.drawingView.drawingMode = QLDrawingMode_Earse;
    } else {
        self.drawingView.drawingMode = QLDrawingMode_None;
        
    }
    self.drawBtn.selected = NO;

}

- (IBAction)calearAll:(UIButton *)sender {
    [self.drawingView clearScreen];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
