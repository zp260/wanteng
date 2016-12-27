//
//  ImgSrcFix.m
//  wanteng
//
//  Created by mrz on 2016/12/15.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "ImgSrcFix.h"

@implementation ImgSrcFix

#pragma mark - 转换图片路径

/**
 转换图片路径

 @param html 原来的html源码
 @return return value 修改好的url的源码 src带全域名的
 */
+(NSString *)fixedImageSrcHtml:(NSString*)html withImgWidth:(CGFloat)width{
    
    NSRegularExpression *imgRegex = [NSRegularExpression regularExpressionWithPattern:@"<img\\ssrc[^>]*/>" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *imgResult = [imgRegex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    NSMutableDictionary *urlDicts = [[NSMutableDictionary alloc] init];
    NSString *docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];//本地路径
    for(NSTextCheckingResult *item in imgResult){
        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];
        NSArray *tmpArr = [[NSArray alloc]init];
        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
            tmpArr = [imgHtml componentsSeparatedByString:@"src=\""];
        }else if([imgHtml rangeOfString:@"src="].location !=NSNotFound){
            tmpArr = [imgHtml componentsSeparatedByString:@"src="];
        }
        if (tmpArr.count >=2){
            NSString *src = tmpArr[1];
            NSInteger loc = [src rangeOfString:@"\""].location;
            if (loc!=NSNotFound) {
                src = [src substringToIndex:loc];
                NSLog(@"正确解析出来的src为:%@",src);
                if (src.length>0) {
                    NSString *localPath =[NSString stringWithFormat:@"%@%@",@"http://www.dtcqzf.gov.cn",src];
                    [urlDicts setObject:localPath forKey:src];
                }
            }
        }
    }
    
    // 遍历所有的URL，替换成本地的URL，并异步获取图片
    for (NSString *src in urlDicts.allKeys) {
        NSString *localPath = [urlDicts objectForKey:src];
        html = [html stringByReplacingOccurrencesOfString:src withString:localPath];
        
        
    }
    
    //修改图片大小
    NSString *css = [NSString stringWithFormat:@"%@%f%@",@"<style type=\"text/css\">img{width:",300.0f,@"px;}</style>"];
    NSLog(@"源代码为:\n%@",html);
    html = [NSString stringWithFormat:@"%@%@",html,css];
    return html;
}

@end
