//
//  ViewController.m
//  ipadWeb
//
//  Created by 朱明科 on 16/3/23.
//  Copyright © 2016年 zhumingke. All rights reserved.
//

#import "ViewController.h"
#import "GTMBase64.h"

@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic)UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor cyanColor];
    self.webView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-80)];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.delegate =self;
    self.webView.scalesPageToFit = NO;
    self.webView.scrollView.bounces = NO;
    NSString *basePath = [[NSBundle mainBundle]bundlePath];
    NSString *helpHtmlPath = [basePath stringByAppendingPathComponent:@"setColor.html"];
    NSURL *url = [NSURL fileURLWithPath:helpHtmlPath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:_webView];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, self.view.frame.size.height-80, 50, 40);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(tt) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)tt{
    NSString *str = [self.webView stringByEvaluatingJavaScriptFromString:@"postImg()"];
    NSString *subStr = [str substringFromIndex:22];
    NSData *s = [subStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data2 = [GTMBase64 decodeData:s];

    UIImage *image = [UIImage imageWithData:data2];
    [self.webView removeFromSuperview];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50, 300, 300)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor redColor];
    imageView.image = image;
    [self.view addSubview:imageView];

    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    UIImage *images = [UIImage imageNamed:@"girl.png"];
    NSData *data = UIImagePNGRepresentation(images);
    NSData *encryData = [GTMBase64 encodeData:data];
    //NSLog(@"------%s",encryData.bytes);

    NSString *js = [NSString stringWithFormat:@"getImg('%s')",encryData.bytes];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

@end
