//
//  TableviewController.m
//  AutoCellForHeight
//
//  Created by archy on 16/5/30.
//  Copyright © 2016年 archy. All rights reserved.
//
#define KmainWith  [UIScreen mainScreen].bounds.size.width
#define kmainHeight [UIScreen mainScreen].bounds.size.height

#import "TableviewController.h"
#import "MyTableviewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MydataModel.h"

typedef NS_ENUM(NSInteger,FDSimulatedCacheMode) {
    FDSimulatedCacheModeNone = 0,
    FDSimulatedCacheModeCacheByIndexPath,
    FDSimulatedCacheModeCacheByKey
};

static  NSString  *CellIndentifer  =@"CellIndentifer";
@interface TableviewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *MyContent;

@property (nonatomic,strong)NSMutableArray *MydataArray;
@end

@implementation TableviewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.MyContent.fd_debugLogEnabled = NO;
    [self.view addSubview:self.MyContent];
    self.view.backgroundColor =[UIColor orangeColor];
    [self getDataThen:^{
        [self.MyContent reloadData];
    }];
}
-(void)getDataThen:(void(^)(void))then
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *datafilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data =[NSData dataWithContentsOfFile:datafilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        
        NSMutableArray *entities = @[].mutableCopy;
        [feedDicts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [entities addObject:[[MydataModel alloc]initWithDictionary:obj]];
        }];
        [self.MydataArray  addObjectsFromArray: entities];
        dispatch_async(dispatch_get_main_queue() , ^{
            !then ?: then();
        });
    });
}
-(UITableView *)MyContent
{
    if (!_MyContent) {
        _MyContent =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KmainWith, kmainHeight)];
        _MyContent.delegate = self;
        _MyContent.dataSource = self;
        [_MyContent registerClass:[MyTableviewCell class] forCellReuseIdentifier:CellIndentifer];
    }
    return _MyContent;
}
-(NSMutableArray *)MydataArray
{
    if (!_MydataArray) {
        _MydataArray =[[NSMutableArray alloc]init];
    }
    return _MydataArray;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.MydataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MydataModel *model = self.MydataArray[indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:CellIndentifer cacheByIndexPath:indexPath configuration:^(MyTableviewCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableviewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIndentifer];
    [self configureCell:cell atIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)configureCell:(MyTableviewCell *)cell atIndexPath:(NSIndexPath *)indexpath
{
//    cell.fd_enforceFrameLayout = YES;
    cell.Model = self.MydataArray[indexpath.row];
}
@end
