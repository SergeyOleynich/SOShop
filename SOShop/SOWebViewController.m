//
//  SOWebViewController.m
//  SOShop
//
//  Created by Sergey on 01.03.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOWebViewController.h"

@interface SOWebViewController () <UIWebViewDelegate, NSURLConnectionDataDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *loadLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rewindButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *stopButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;

- (IBAction)actionRewind:(UIBarButtonItem *)sender;
- (IBAction)actionStopLoading:(UIBarButtonItem *)sender;
- (IBAction)actionForward:(UIBarButtonItem *)sender;

@property (strong, nonatomic) UIBarButtonItem *rightBarButtonItem;
@property (assign, nonatomic) BOOL isOpenHTML;
@property (strong, nonatomic) UITextView *HTMLText;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation SOWebViewController

#pragma mark - Setters

-(void)setMainTitle:(NSString *)mainTitle {
    
    _mainTitle = mainTitle;
    
    [self.navigationItem setTitle:NSLocalizedString(mainTitle, nil)];
    
}

#pragma mark - View appear

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
     
     NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
     */
    
    if (self.url != nil) {
        if ([self.url.path.pathExtension isEqualToString:@"jpg"]) {
            
            NSString *path = [[NSBundle mainBundle] bundlePath];
            NSURL *baseURL = [NSURL fileURLWithPath:path];
            NSString *nameOfFile = self.url.path.lastPathComponent;
            NSString *htmlString = [NSString stringWithFormat:@"<img src=\"%@\">", nameOfFile];
            [self.webView loadHTMLString:htmlString baseURL:baseURL];
            
        } else {
            
            _rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"HTML" style:UIBarButtonItemStylePlain target:self action:@selector(getHTML:)];
            
            self.isOpenHTML = NO;
            
            [self.navigationItem setRightBarButtonItem:self.rightBarButtonItem];
            
            [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
            
        }
    } else {
        
        [self.webView loadData:self.data MIMEType:@"application/msword" textEncodingName:@"UTF-8" baseURL:nil];
        
    }
    
    [self.stopButton setEnabled:NO];
    [self refreshUIToolbarButtons];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.loadLabel.text = NSLocalizedString(@"Loading", nil);
    
    [self startLoadLabelAnimation];
    
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)dealloc {
    NSLog(@"DEALLOCATED SOWEBVIEW");
    [_timer invalidate];
    _timer = nil;
    _rightBarButtonItem = nil;
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"LENGHT: %lld", response.expectedContentLength);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"CURRENT: %li", data.length);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self.stopButton setEnabled:YES];
    [self.activity startAnimating];
    
    [self.progress setHidden:NO];
    [self.progress setProgress:0.15f animated:YES];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    
    if ([self.loadLabel isHidden]) {
        
        [self.loadLabel setHidden:NO];
        [self startLoadLabelAnimation];
        
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.stopButton setEnabled:NO];
    [self.progress setProgress:1.f animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.activity stopAnimating];
        [self.loadLabel setHidden:YES];
        [self.progress setHidden:YES];
        _timer = nil;
    });
    [self refreshUIToolbarButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self.stopButton setEnabled:YES];
    [self.activity stopAnimating];
    [[[UIAlertView alloc] initWithTitle:@"Open link/file error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [self refreshUIToolbarButtons];
}

#pragma mark - UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    [self closeHTMLTextViewWithRequest:URL];
    
    return NO;
}

#pragma mark - Helper methods

- (void)closeHTMLTextViewWithRequest:(NSURL *)loadURL {
    
    NSURL *tempURL = loadURL;
    
    [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.HTMLText.frame = CGRectMake(CGRectGetMinX(self.view.frame) + 20.f, CGRectGetMinY(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
            self.HTMLText.frame = CGRectMake(-CGRectGetMaxX(self.view.frame), CGRectGetMinY(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        } completion:^(BOOL finished) {
            [self.HTMLText removeFromSuperview];
            if (tempURL) {
                NSURLRequest *request = [NSURLRequest requestWithURL:tempURL];
                [self.webView loadRequest:request];
            }
        }];
    }];
    
    [self.rightBarButtonItem setTitle:@"HTML"];
    
    self.isOpenHTML = NO;
}

- (void)startLoadLabelAnimation {
    
    [UIView animateWithDuration:1.f
                          delay:0.f
                        options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.loadLabel.transform = CGAffineTransformMakeScale(2.f, 2.f);
                         
                     }
                     completion:^(BOOL finished) {
                         
                         
                         
                     }];
    
}

- (void)updateProgress {
    
    CGFloat currentProgress = self.progress.progress;
    
    NSString *temp = [NSString stringWithFormat:@"%.1f", currentProgress];
    
    if ([temp isEqualToString:@"0.9"]) {
        
        [self.timer invalidate];
        
    }
    
    [self.progress setProgress:(currentProgress + 0.05f) animated:YES];
    
}

- (void)refreshUIToolbarButtons {
    
    self.rewindButton.enabled = [self.webView canGoBack];
    self.forwardButton.enabled = [self.webView canGoForward];
    
}

#pragma mark - Actions

- (void)getHTML:(UIBarButtonItem *)sender {
    
    if (!self.isOpenHTML) {
        [self.rightBarButtonItem setTitle:NSLocalizedString(@"Close", nil)];
        
        if (!self.HTMLText) {
            _HTMLText = [[UITextView alloc] init];
        }
        
        self.HTMLText.delegate = self;
        self.HTMLText.frame = CGRectMake(CGRectGetMaxX(self.view.frame), CGRectGetMinY(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        
        [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.HTMLText.frame = CGRectMake(CGRectGetMinX(self.view.frame) - 20.f, CGRectGetMinY(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
                self.HTMLText.frame = CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMinY(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
            } completion:nil];
        }];
        /*
         NSError *error = nil;
         NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink
         error:&error];
         
         NSString *string = [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
         NSMutableAttributedString *stringAttribute = [[NSMutableAttributedString alloc] initWithString:@""];
         [detector enumerateMatchesInString:string
         options:kNilOptions
         range:NSMakeRange(0, [string length])
         usingBlock:
         ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
         NSDictionary * attributes = [NSDictionary dictionaryWithObject:color forKey:NSLinkAttributeName];
         NSAttributedString * subString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", result.URL] attributes:attributes];
         NSLog(@"Match: %@", result.URL);
         }];
         
         NSLog(@"%@", stringAttribute);
         */
        
        self.HTMLText.dataDetectorTypes = UIDataDetectorTypeLink;
        
        [self.HTMLText setEditable:NO];
        [self.HTMLText setTextContainerInset:UIEdgeInsetsMake(CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + 2.f, 0.f, 5.f, 0.f)];
        
        NSString *yourHTMLSourceCodeString = [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
        [self.HTMLText setText:yourHTMLSourceCodeString];
        [self.view addSubview:self.HTMLText];
        self.isOpenHTML = YES;
        
    } else {
        [self closeHTMLTextViewWithRequest:nil];
    }
    
}

- (IBAction)actionRewind:(UIBarButtonItem *)sender {
    
    if ([self.webView canGoBack]) {
        [self.webView stopLoading];
        [self.webView goBack];
    }
    
}

- (IBAction)actionStopLoading:(UIBarButtonItem *)sender {
    
    [self.webView stopLoading];
    [self.activity stopAnimating];
    [self.loadLabel setHidden:YES];
    [self.progress setHidden:YES];
    
}

- (IBAction)actionForward:(UIBarButtonItem *)sender {
    
    if ([self.webView canGoForward]) {
        [self.webView stopLoading];
        [self.webView goForward];
    }
    
}

@end








