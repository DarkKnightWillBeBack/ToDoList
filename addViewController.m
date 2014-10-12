//
//  addViewController.m
//  start
//
//  Created by 谢润丰 on 14-9-23.
//  Copyright (c) 2014年 StarkIndustry. All rights reserved.
//

#import "addViewController.h"

@interface addViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *donebutton;

@end

@implementation addViewController

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = self.view.frame;
    frame.origin.y -= 216;
    frame.size.height += 216;
    self.view.frame = frame;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect frame1 = self.view.frame;
    if (![self.textfield isExclusiveTouch]&&(frame1.origin.y < 0)) {
        [self.textfield resignFirstResponder];
        CGRect frame = self.view.frame;
        frame.origin.y += 216;
        frame.size.height -= 216;
        self.view.frame = frame;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGRect frame = self.view.frame;
    frame.origin.y += 216;
    frame.size.height -= 216;
    self.view.frame = frame;
    [textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.donebutton) {
        return;
    }else{
        if (self.textfield.text.length > 0) {
            self.todoitem = [[ToDoItem alloc]init];
            self.todoitem.itemname = self.textfield.text;
            self.todoitem.completed = NO;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
