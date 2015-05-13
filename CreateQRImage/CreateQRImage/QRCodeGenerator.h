//
//  QRCodeGenerator.h
//  二维码
//
//  Created by Mac on 15-5-13.
//  Copyright (c) 2015年 wmeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QRCodeGenerator : NSObject
/**
 *  生成二维码图片
 *
 *  @param qrString 内容
 *  @param size     大小
 *
 *  @return 二维码图片
 */
+ (UIImage *)QRCodeForString:(NSString *)qrString size:(CGFloat)size;
/**
 *  生成二维码图片
 *
 *  @param qrString  内容
 *  @param size      大小
 *  @param fillColor 填充的颜色
 *
 *  @return 二维码图片
 */
+ (UIImage *)QRCodeForString:(NSString *)qrString size:(CGFloat)size fillColor:(UIColor *)fillColor;
/**
 *  根据二维码的
 *
 *  @param twoDimensionCode 二维码的img
 *  @param avatarImage      加载在二维码的图片
 *
 *  @return 加载图片的二维码图片
 */
+ (UIImage *)QRCodeTwoDimensionCodeImage:(UIImage *)twoDimensionCode withAvatarImage:(UIImage *)avatarImage;
/**
 *  生成二维码图片
 *
 *  @param string    生成二维码的内容
 *  @param size       生成二维码的大小
 *  @param avatarImage 加载再二维码的图片
 *
 *  @return 二维码图片
 */
+ (UIImage *)QRCodeImageForString:(NSString *)string imageSize:(CGFloat)size withAvatarImage:(UIImage *)avatarImage;
/**
 *  生成二维码图片
 *
 *  @param qrString    生成二维码的内容
 *  @param size        大小
 *  @param fillColor   填充的颜色
 *  @param avatarImage 加载的图片
 *
 *  @return 新的二维码图片
 */
+ (UIImage *)QRCodeForString:(NSString *)qrString size:(CGFloat)size fillColor:(UIColor *)fillColor withAvatarImage:(UIImage *)avatarImage;

@end
