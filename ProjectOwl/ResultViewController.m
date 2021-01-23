//
//  ResultViewController.m
//  ProjectOwl

#import "ResultViewController.h"
@interface ResultViewController ()

@end

@implementation ResultViewController

- (IBAction)goBackPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:NULL];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:_backButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self findMeaning:_searchWord];
    // Do any additional setup after loading the view.
}

- (void)findMeaning:(NSString*) str {
    NSLog(@"entered findMeaning");
    _indicator.hidden = false;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:configuration];
    NSMutableString *urlString = [NSMutableString stringWithString: @"https://owlbot.info/api/v4/dictionary/"];
    [urlString appendString:str];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"Token ef0cf797972f4be61700454fed0726e5b31f06a0" forHTTPHeaderField:@"Authorization"];
    [request addValue:@"application/json" forHTTPHeaderField: @"Content-Type"];

    [[urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error in getting response: %@", error);
        }
        else {
            NSData *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &error];
            if ([[[jsonData valueForKey:@"message"] firstObject]  isEqual: @"No definition :("]) {
                [self showErrorData];
            } else {
                [self showData: jsonData];
            }
        }

    }]resume];
}

- (void)showErrorData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_word setText:_searchWord];
        [self->_meaning setText:@"No such word is available inside me! \n Search another word"];
        [self->_image setImage: [UIImage imageNamed:@"NoImage.png"]];
    });
}

- (void)showData: (NSData*) data {
    NSLog(@"entered showData");
     NSObject *definitionJSON = [[data valueForKey:@"definitions"] firstObject];

    NSString * _Nullable example = [definitionJSON valueForKey:@"example"];

    NSString * _Nullable imageUrl = [definitionJSON valueForKey:@"image_url"];

    if (![imageUrl isKindOfClass:[NSNull class]]) {
        [self updateImage:imageUrl];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_image setImage: [UIImage imageNamed:@"NoImage.png"]];
        });
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_indicator setHidden:true];
        [self->_word setText:[data valueForKey:@"word"]];
        [self->_pronunciation setText:[data valueForKey:@"pronunciation"]];
        [self->_type setText:[definitionJSON valueForKey:@"type"]];
        [self->_meaning setText:[definitionJSON valueForKey:@"definition"]];

        if (![example isKindOfClass: [NSNull class]]) {
            [self->_example setText:[definitionJSON valueForKey:example]];
        }
    });

}

- (void) updateImage: (NSString*) urlString {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_image setImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]]];
    });
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
