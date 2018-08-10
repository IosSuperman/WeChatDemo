// See http://iphonedevwiki.net/index.php/Logos
#import <UIKit/UIKit.h>

@interface MMTableViewInfo

- (long long)numberOfSectionsInTableView:(id)arg1;

@end

@interface NewSettingViewController : UIViewController

@end


%hook NewSettingViewController

- (void)viewDidLoad
{
    %orig;
    
    // 键盘监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

%new
- (void)keyboardWillShow:(NSNotification *)notice
{
    CGRect keyboardRect = [[notice.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.view.frame = CGRectMake(0, -keyboardRect.size.height, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height);
}

%new
- (void)keyboardWillHide:(NSNotification *)notice
{
//    self.view.transform = CGAffineTransformIdentity;
    self.view.frame =  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height);
}

%new
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

%end

%hook MMTableViewInfo

- (double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定位到设置界面 && 最后一组
    if ([tableView.nextResponder.nextResponder isKindOfClass:%c(NewSettingViewController)] && indexPath.section == [self  numberOfSectionsInTableView:tableView]-1)
    {
        return 44.f;
    }
    return %orig;
}

#pragma mark -- 绘制每个 Cell
- (id)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定位到设置界面 && 最后一组
    if ([tableView.nextResponder.nextResponder isKindOfClass:%c(NewSettingViewController)] && indexPath.section == [self  numberOfSectionsInTableView:tableView]-1)
    {
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellId"];
//        cell.backgroundColor = [UIColor purpleColor];
//        cell.textLabel.text = @"添加的 Cell";
        
        UITableViewCell *cell = nil;
        static NSString *cellId = @"";
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
            }
            cell.textLabel.text = @"自动抢红包";
            cell.accessoryView = [[UISwitch alloc] init];
        }else
        {
            cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
            }
            cell.textLabel.text = @"等待时间（秒）";
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 2, 150, 40)];
            textField.placeholder = @"设置抢红包等待时间";
            textField.borderStyle = UITextBorderStyleRoundedRect;
            cell.accessoryView = textField;
        }
        cell.backgroundColor = [UIColor whiteColor];

        return cell;
    }
    return %orig;
}

#pragma mark -- 每组多少行
- (long long)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 定位到设置界面 && 最后一组
    if ([tableView.nextResponder.nextResponder isKindOfClass:%c(NewSettingViewController)] && section == [self  numberOfSectionsInTableView:tableView]-1)
    {
        return 2;
    }
    return %orig;
}

#pragma mark -- 多少组
- (long long)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"%@",arg1);
//    NSMutableArray *array = MSHookIvar<NSMutableArray *>(self, "_arrSections");
//    NSLog(@"现在是：%d---原来是：%d",array.count,%orig);
    
//    if ([tableView.nextResponder.nextResponder isKindOfClass:NSClassFromString(@"NewSettingViewController")]) {
//        NSLog(@"设置界面");
//    }
    if ([tableView.nextResponder.nextResponder isKindOfClass:%c(NewSettingViewController)]) {
        NSLog(@"This is 设置界面");
        
        return %orig + 1;
    }

    return %orig;
}

// 收回键盘
- (void)scrollViewWillBeginDragging:(id)arg1
{
    [MSHookIvar <UITableView *> (self,"_tableView") endEditing:YES];
}

%end
