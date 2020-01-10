//
//  CustomCreateIdentityTableViewCell.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomCreateIdentityTableViewCell.h"

@interface CustomCreateIdentityTableViewCell ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;



@end

@implementation CustomCreateIdentityTableViewCell
- (IBAction)buttonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.itemModel.isEntry = sender.selected;
    self.textField.secureTextEntry = sender.selected;
}

- (void)setItemModel:(CustomCreateIdentityItemModel *)itemModel {
    _itemModel =itemModel;
    if (_itemModel) {
        self.textField.placeholder = _itemModel.placeholder;
        self.textField.text = _itemModel.value;
        self.button.hidden = YES;
        switch (_itemModel.type) {
            case CreateIdentityItemType_Name:
                {
                    self.button.hidden = YES;
                    self.textField.secureTextEntry = NO;
                }
                break;
            case CreateIdentityItemType_NewPassword:
            {
                self.button.hidden = YES;
//                self.textField.textContentType = UITextContentTypePassword;
            }
                break;
                
            case CreateIdentityItemType_Password:
            {
                 self.textField.placeholder = @"Password (8-32 characters, letters and numbers)";
                self.button.hidden = NO;
                self.textField.secureTextEntry = _itemModel.isEntry;
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    @weakify(self);
    [[self.textField rac_textSignal]subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (self.textFieldBlock) {
            self.textFieldBlock(self.itemModel.type,x);
        }
    }];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
