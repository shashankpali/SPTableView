//
//  SPTable.m
//  SPTableView
//
//  Created by Shank on 4/9/15.
//  Copyright (c) 2015 Shank. All rights reserved.
//

#import "SPTable.h"

@implementation SPTable{
    
    NSIndexPath *selectedindex;
    UIView *backview;
    NSTimeInterval lastoffsetcap;
    CGPoint lastoffset;
    BOOL isscrollfast;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate=self;
        self.dataSource=self;
        
        self.yaxis=self.frame.size.height/2;
        
        backview=[[UIView alloc] init];
        
        backview.frame=CGRectMake(0,self.frame.origin.y, self.frame.size.width, self.frame.size.height/2);
        
        
        [self addSubview:backview];
        [self sendSubviewToBack:backview];
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==selectedindex.row) {
        
        return 150;
    }
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mycell"];
    }
    
    cell.backgroundColor=[UIColor colorWithWhite:.3 alpha:1];
    
    //    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    backview.backgroundColor=cell.backgroundColor;
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float speed;
    
    {  CGPoint currentoffset=scrollView.contentOffset;
        
        NSTimeInterval currenttime=[NSDate timeIntervalSinceReferenceDate];
        
        
        NSTimeInterval timediff=currenttime-lastoffsetcap;
        
        if (timediff>0.1) {
            CGFloat dist=currentoffset.y-lastoffset.y;
            
            CGFloat scrollspeednotabs=(dist*10)/1000;
            
            CGFloat scrollspeed=fabsf(scrollspeednotabs);
            
            speed=scrollspeed;
            
            if (scrollspeed>0.5) {
                isscrollfast =YES;
                // NSLog(@"fast");
            }else{
                isscrollfast=NO;
                // NSLog(@"slow");
            }
            
            lastoffset=currentoffset;
            lastoffsetcap=currenttime;
        }
    }
    
    if (speed<.01) {
        
        backview.frame=CGRectMake(0,0, self.frame.size.width, scrollView.contentSize.height);
        
        selectedindex=[self indexPathForRowAtPoint:CGPointMake(0,scrollView.contentOffset.y+_yaxis)];
        
        [self beginUpdates];
        [self endUpdates];
    }
    
}

@end
