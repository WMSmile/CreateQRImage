//
//  QRCodeGenerator.m
//  二维码
//
//  Created by Mac on 15-5-13.
//  Copyright (c) 2015年 wmeng. All rights reserved.
//

#import "QRCodeGenerator.h"
#import "qrencode.h"

//enum {
//    qr_margin = 3
//};
@implementation QRCodeGenerator

//+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size {
//    unsigned char *data = 0;
//    int width;
//    data = code->data;
//    width = code->width;
//    float zoom = (double)size / (code->width + 2.0 * qr_margin);
//    CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
//    
//    // draw
//    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
//    for(int i = 0; i < width; ++i) {
//        for(int j = 0; j < width; ++j) {
//            if(*data & 1) {
//                rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
//                CGContextAddRect(ctx, rectDraw);
//            }
//            ++data;
//        }
//    }
//    CGContextFillPath(ctx);
//}
//+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size {
//    if (![string length]) {
//        return nil;
//    }
//    
//    QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_L, QR_MODE_8, 1);
//    if (!code) {
//        return nil;
//    }
//    
//    // create context
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, kCGImageAlphaPremultipliedLast);
//    
//    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
//    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
//    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
//    
//    // draw QR on this context
//    [QRCodeGenerator drawQRCode:code context:ctx size:size];
//    
//    // get image
//    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
//    UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
//    
//    // some releases
//    CGContextRelease(ctx);
//    CGImageRelease(qrCGImage);
//    CGColorSpaceRelease(colorSpace);
//    QRcode_free(code);
//    
//    return qrImage;
//}
#pragma mark - private

+ (void)DrawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size fillColor:(UIColor *)fillColor {
    int margin = 0;
    unsigned char *data = code->data;
    int width = code->width;
    int totalWidth = width + margin * 2;
    int imageSize = (int)floorf(size);
    
    // @todo - review float->int stuff
    int pixelSize = imageSize / totalWidth;
    if (imageSize % totalWidth) {
        pixelSize = imageSize / width;
        margin = (imageSize - width * pixelSize) / 2;
    }
    
    CGRect rectDraw = CGRectMake(0.0f, 0.0f, pixelSize, pixelSize);
    // draw
    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    for(int i = 0; i < width; ++i) {
        for(int j = 0; j < width; ++j) {
            if(*data & 1) {
                rectDraw.origin = CGPointMake(margin + j * pixelSize, margin + i * pixelSize);
                CGContextAddRect(ctx, rectDraw);
            }
            ++data;
        }
    }
    CGContextFillPath(ctx);
}

#pragma mark - public

+ (UIImage *)QRCodeForString:(NSString *)qrString size:(CGFloat)size {
    return [self QRCodeForString:qrString size:size fillColor:[UIColor blackColor]];
}

+ (UIImage *)QRCodeForString:(NSString *)qrString size:(CGFloat)imageSize fillColor:(UIColor *)fillColor {
    if (0 == [qrString length]) {
        return nil;
    }
    
    // generate QR
    QRcode *code = QRcode_encodeString([qrString UTF8String], 0, QR_ECLEVEL_H, QR_MODE_8, 1);
    if (!code) {
        return nil;
    }
    
    CGFloat size = imageSize * [[UIScreen mainScreen] scale];
    if (code->width > size) {
        printf("Image size is less than qr code size (%d)\n", code->width);
        return nil;
    }
    
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // The constants for specifying the alpha channel information are declared with the CGImageAlphaInfo type but can be passed to this parameter safely.
    
    CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
    
    // draw QR on this context
    [self DrawQRCode:code context:ctx size:size fillColor:fillColor];
    
    // get image
    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
    UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
    
    // free memory
    CGContextRelease(ctx);
    CGImageRelease(qrCGImage);
    CGColorSpaceRelease(colorSpace);
    QRcode_free(code);
    return qrImage;
}

+ (UIImage *)QRCodeTwoDimensionCodeImage:(UIImage *)twoDimensionCode withAvatarImage:(UIImage *)avatarImage{
    
    // two-dimension code 二维码
    
    CGSize size = twoDimensionCode.size;
    CGSize size2 =CGSizeMake(1.0 / 5.5 * size.width, 1.0 / 5.5 * size.height);
    
    UIGraphicsBeginImageContext(size);
    
    [twoDimensionCode drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    [avatarImage drawInRect:CGRectMake((size.width - size2.width) / 2.0, (size.height - size2.height) / 2.0, size2.width, size2.height)];
    
    
    
    UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
    
}
+ (UIImage *)QRCodeImageForString:(NSString *)string imageSize:(CGFloat)size withAvatarImage:(UIImage *)avatarImage
{
    UIImage *bgImg = [self QRCodeForString:string size:size];
    return  [self QRCodeTwoDimensionCodeImage:bgImg withAvatarImage:avatarImage];
}
+ (UIImage *)QRCodeForString:(NSString *)qrString size:(CGFloat)size fillColor:(UIColor *)fillColor withAvatarImage:(UIImage *)avatarImage
{
    UIImage *bgImg = [self QRCodeForString:qrString size:size fillColor:fillColor];
    return  [self QRCodeTwoDimensionCodeImage:bgImg withAvatarImage:avatarImage];
}












//+ (UIImage *) avatarImage:(UIImage *)avatarImage{
//    
//    UIImage * avatarBackgroudImage = [UIImage imageNamed:@"icon.png"];
//    
//    CGSize size = avatarBackgroudImage.size;
//    
//    UIGraphicsBeginImageContext(size);
//    
//    
//    
//    [avatarBackgroudImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    
//    [avatarImage drawInRect:CGRectMake(10, 10, size.width - 20, size.height - 20)];
//    
//    
//    
//    UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return resultingImage;
//    
//}



@end
