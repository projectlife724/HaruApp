//
//  HRCollectionViewCell.h
//  Haru
//
//  Created by Won Suk Choi on 2017. 3. 30..
//  Copyright © 2017년 jcy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *cellMainView;
@property (weak, nonatomic) IBOutlet UITextView *dateTextView;
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end