//
//  ResultViewController.h
//  ProjectOwl


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResultViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UILabel *word;
@property (strong, nonatomic) IBOutlet UILabel *pronunciation;
@property (strong, nonatomic) IBOutlet UILabel *type;
@property (strong, nonatomic) IBOutlet UILabel *meaning;
@property (strong, nonatomic) IBOutlet UILabel *example;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic) NSString *searchWord;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

- (IBAction)goBackPressed:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
