//
//  ICSudokuLockView.m
//  ICSudokuLockView
//
//  Created by CSX on 2017/3/17.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "ICSudokuLockView.h"

typedef enum :NSInteger{
    buttonTag = 1000,
}tags;

@interface ICSudokuLockView ()<UIAlertViewDelegate>
@property(nonatomic , strong)NSMutableArray *buttonsArr;
@property(nonatomic , assign)CGPoint currentPoint;

@end

@implementation ICSudokuLockView

- (NSMutableArray *)buttonsArr{
    if (!_buttonsArr) {
        _buttonsArr = [NSMutableArray array];
    }
    return _buttonsArr;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView{
    for (int i = 0; i<9; i++) {
        UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
        buton.frame = CGRectMake(40+i%3*120, 20+i/3*120, 80, 80);
        [buton setImage:[UIImage imageNamed:@"n"] forState:UIControlStateNormal];
        [buton setBackgroundImage:[UIImage imageNamed:@"s"] forState:UIControlStateSelected];
        buton.tag = buttonTag + i;
        [self addSubview:buton];
        buton.userInteractionEnabled = NO;
    }
}

//获取点击开始第一个butto  添加到一定数组集合
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取点击的点位
    CGPoint point = [[touches anyObject] locationInView:self];
    for (UIButton *tempBtn in self.subviews) {
        //判断是否有交集（button和point点）
        if (CGRectContainsPoint(tempBtn.frame, point)) {
            //让按钮的图片修改图片显示点击的效果
            tempBtn.selected = YES;
            [self.buttonsArr addObject:tempBtn];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    self.currentPoint = point;
    for (UIButton *button in self.subviews) {
       
        if (CGRectContainsPoint(button.frame, point)) {
            if (button.selected) {
                
            }else{
                button.selected = YES;
                [self.buttonsArr addObject:button];
            }
           
        }
    }
    [self setNeedsDisplay];//调用画线方法
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    self.currentPoint = point;
    
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, point)) {
        
        }else{
            self.currentPoint = [[self.buttonsArr lastObject] center];
        }
    }
    [self setNeedsDisplay];//调用画线方法
    
    //显示手势密码
    [self clearAllbackForNew];
}

- (void)clearAllbackForNew{
    if (self.buttonsArr.count == 0) {
        return;
    }
    NSString *str;
    for (int i = 0 ;i<self.buttonsArr.count;i++) {
        UIButton *tempBtn = self.buttonsArr[i];
        if (i == 0) {
            str = [NSString stringWithFormat:@"%ld",tempBtn.tag-buttonTag];
        }else{
            str = [NSString stringWithFormat:@"%@-%ld",str,tempBtn.tag-buttonTag];
        }
    }
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"您的手势密码是" message:str delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alerView show];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    if (self.buttonsArr.count == 0) {
        return;
    }
    //获取上下文来绘图
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //开始绘图
    CGContextBeginPath(context);
    
    for (int i = 0; i<self.buttonsArr.count; i++) {
        CGPoint point = [self.buttonsArr[i] center];
        if ( i == 0) {
            CGContextMoveToPoint(context, point.x, point.y);
        }else{
            CGContextAddLineToPoint(context, point.x, point.y);
        }
    }
    CGContextAddLineToPoint(context, self.currentPoint.x, self.currentPoint.y);
    
    CGContextSetLineWidth(context,5);//线条的粗细
    CGContextSetRGBStrokeColor(context,0.5, 0.5, 0.5, 0.5);//线条颜色  （红、绿、蓝、清晰度）
//    [[UIColor redColor] setStroke];  // 线条颜色设置的另一种方式
    //描线
    CGContextStrokePath(context);
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    for (UIButton *button in self.buttonsArr) {
        button.selected = NO;
    }
    [self.buttonsArr removeAllObjects];
    
    [self setNeedsDisplay];
}




@end
