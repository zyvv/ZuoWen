//
//  UIImage+Text.m
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/25.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import "UIImage+Text.h"

@implementation UIImage (Text)

-(UIImage *)imageFromText:(NSArray*)arrContent withFont: (CGFloat)fontSize {
    
    // set the font type and size
    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    NSMutableArray *arrHeight = [[NSMutableArray alloc] initWithCapacity:arrContent.count];
    
    
    
    CGFloat fHeight = 0.0f;
    
    for (NSString *sContent in arrContent) {
        
        CGSize stringSize = [sContent sizeWithFont:font constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 10000) lineBreakMode:UILineBreakModeWordWrap];
        
        [arrHeight addObject:[NSNumber numberWithFloat:stringSize.height]];
        
        fHeight += stringSize.height;
        
    }
    
    
    
    CGSize newSize = CGSizeMake([UIScreen mainScreen].bounds.size.width+20, fHeight+50);
    
    
    
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetCharacterSpacing(ctx, 10);
    
    CGContextSetTextDrawingMode (ctx, kCGTextFillStroke);
    
    CGContextSetRGBFillColor (ctx, 0.1, 0.2, 0.3, 1); // 6
    
    CGContextSetRGBStrokeColor (ctx, 0, 0, 0, 1);
    
    
    
    int nIndex = 0;
    
    CGFloat fPosY = 20.0f;
    
    for (NSString *sContent in arrContent) {
        
        NSNumber *numHeight = [arrHeight objectAtIndex:nIndex];
        
        CGRect rect = CGRectMake(10, fPosY, [UIScreen mainScreen].bounds.size.width - 20 , [numHeight floatValue]);
        
        [sContent drawInRect:rect withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
        
        
        
        fPosY += [numHeight floatValue];
        
        nIndex++;
        
    }
    
    // transfer image
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    return image;
    
}


@end
