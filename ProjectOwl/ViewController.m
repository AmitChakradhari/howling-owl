//
//  ViewController.m
//  ProjectOwl

#import "ViewController.h"
#import "ResultViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search button clicked");
    NSString * _Nullable searchWord = [searchBar text];
    if (![searchWord isKindOfClass:[NSNull class]]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ResultViewController *resultViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ResultViewController"];
        resultViewController.searchWord = searchWord;
        [self performSegueWithIdentifier:@"SegueToResultView" sender:self];
        
        //[self presentViewController:resultViewController animated:YES completion:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"SegueToResultView"]) {
        if ([segue.destinationViewController isKindOfClass:[ResultViewController class]]) {
            ResultViewController *resultViewController = segue.destinationViewController;
            resultViewController.searchWord = _searchBar.text;
        }
    }

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
