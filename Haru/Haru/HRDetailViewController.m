//
//  HRDetailViewController.m
//  Haru
//
//  Created by 조백진 on 2017. 3. 29..
//  Copyright © 2017년 jcy. All rights reserved.
//

#import "HRDetailViewController.h"
#import "HRCustomTableViewCell.h"
#import "HRMainViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HRDetailViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *detailViewRightBarButton;

@end

@implementation HRDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%ld", self.indexPath.row);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


    

- (IBAction)buttonClick:(UIBarButtonItem *)sender {
    
    if ([[sender backgroundImageForState:UIControlStateNormal barMetrics:UIBarMetricsDefault] isEqual:[UIImage imageNamed:@"Pencil"]]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"Streaks"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"Pencil"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
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
