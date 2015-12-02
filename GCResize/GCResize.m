//
//  GCResize.m
//  Go Code Foundation
//
//  Created by Zach Silveira on 12/2/15.
//

#import "RCTBridgeModule.h"
@import CoreGraphics;
@import UIKit;



@interface GCResize : NSObject <RCTBridgeModule>
@end

@implementation GCResize;


RCT_EXPORT_MODULE();

//resize the image to the specified dimensions
UIImage *Resize(NSDictionary *input)
{
    CGSize size = CGSizeMake([input[@"width"] intValue], [input[@"height"] intValue]);
    UIGraphicsBeginImageContext(size);
    UIImage *image = [UIImage imageWithContentsOfFile:[input objectForKey:@"image"]];
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return croppedImage;
}

//save to disk temporarily
NSString *createTempImage(UIImage *image)
{
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSString *tempImage = [tmpDirectory stringByAppendingPathComponent:@"temp.png"];
    [UIImagePNGRepresentation(image) writeToFile:tempImage atomically:YES];
    return tempImage;
}

//image -> resized base64
RCT_EXPORT_METHOD(base64:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    UIImage * croppedImage = Resize(input);
    NSString *base64 = [UIImagePNGRepresentation(croppedImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *pngBase64 = [NSString stringWithFormat:@"%s%@", "data:image/png;base64,", base64];
    callback(@[pngBase64]);
}



//image -> cropped image path
RCT_EXPORT_METHOD(path:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    UIImage *croppedImage = Resize(input);
    NSString *tempImagePath = createTempImage(croppedImage);
    callback(@[tempImagePath]);
}
@end
