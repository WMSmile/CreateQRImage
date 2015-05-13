//
//  ViewController.m
//  CreateQRImage
//
//  Created by Mac on 15-5-13.
//  Copyright (c) 2015年 wmeng. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeGenerator.h"

@interface ViewController ()
{
    UITextField *_text;
    UIImageView *_Img;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _text = [[UITextField alloc]initWithFrame:CGRectMake(0, 20, 200, 40)];
    _text.layer.borderColor = [UIColor blackColor].CGColor;
    _text.layer.borderWidth = 1.0f;
    [self.view addSubview:_text];
    
    //返回的按钮
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    createBtn.frame = CGRectMake(200, 20, 100, 40);
    createBtn.backgroundColor = [UIColor lightGrayColor];
    [createBtn setTitle:@"生成二维码" forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(createBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:createBtn];
    
    _Img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, 320, 320)];
    [self.view addSubview:_Img];
    
    
}
/**
 *  创建二维码
 *
 *  @param sender 按钮自身
 */
- (void)createBtnClick:(UIButton *)sender
{
    _Img.image = [QRCodeGenerator QRCodeForString:_text.text size:80 fillColor:[UIColor redColor] withAvatarImage:[UIImage imageNamed:@"icon_pay_qi"]];
}

/**
 * 取消输入法
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
