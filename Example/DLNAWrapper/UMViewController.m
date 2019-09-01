//
//  UMViewController.m
//  DLNAWrapper
//
//  Created by Ramon Vicente on 08/31/2019.
//  Copyright (c) 2019 Ramon Vicente. All rights reserved.
//

#import "UMViewController.h"
#import <DLNAWrapper/DLNAWrapper.h>
#import <DLNAWrapper/ControlPoint.h>
#import <DLNAWrapper/Stop.h>
#import <DLNAWrapper/SetURI.h>
#import <DLNAWrapper/Play.h>

@interface UMViewController ()<UITableViewDataSource, UITableViewDelegate, DeviceChangeDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) ControlPoint *mediaControlPoint;
@property(strong, nonatomic) ControlPoint *renderingControlPoint;
@end

@implementation UMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[DLNAWrapper sharedInstance] setDelegate:self];
    [[DLNAWrapper sharedInstance] startAndSearch:YES];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    Device *device = [[[DLNAWrapper sharedInstance] getDeviceList] objectAtIndex:indexPath.row];
    cell.textLabel.text = device.name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DLNAWrapper sharedInstance] getDeviceList] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Device *device = [[[DLNAWrapper sharedInstance] getDeviceList] objectAtIndex:indexPath.row];

    self.mediaControlPoint = [[ControlPoint alloc] initWithService:device.mediaControlService];
    self.renderingControlPoint = [[ControlPoint alloc] initWithService:device.renderingControlService];

    Stop *stop = [[Stop alloc] initWithSuccess:^{
        [self setUri];
    } failure:^(NSError *error) {
        NSLog(@"StopError: %@", error);
    }];

    [self.mediaControlPoint executeAction:stop];
}

- (void) setUri {
    SetURI *setUri = [[SetURI alloc] initWithURI:@"https://umobi.com.br/videos/umobi-intro.mp4" success:^{
        [self play: nil];
    } failure:^(NSError *error) {
        NSLog(@"SetURIError: %@", error);
    }];
    [self.mediaControlPoint executeAction:setUri];
}
- (void)play:(id)sender {
    Play *playAction = [[Play alloc] initWithSuccess:^{

    } failure:^(NSError *error) {
        NSLog ( @"PlayError: %@", error);
    }];

    [self.mediaControlPoint executeAction:playAction];
}

- (void)onChange {
    [self.tableView reloadData];
}
@end
