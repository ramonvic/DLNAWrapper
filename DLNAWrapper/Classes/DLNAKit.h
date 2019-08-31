//
//  DLNAKit.h
//  DLNAKit
//
//  Created by Ramon Silva on 31/08/19.
//

#import <Foundation/Foundation.h>
#import <CocoaAsyncSocket/GCDAsyncUdpSocket.h>
#import "DeviceChangeDelegate.h"
#import "Device.h"

NS_ASSUME_NONNULL_BEGIN

@interface DLNAKit : NSObject<GCDAsyncUdpSocketDelegate>

@property (nonatomic, weak) id<DeviceChangeDelegate> delegate;

/**
 Get DLNAKit instance
 @return DLNAUpnpServer instance
 */
+ (DLNAKit *)sharedInstance;

/**
 Start the Upnp service, the device is not searched by default.
 */
- (void)start;


/**
 Start the Upnp service
 @param isSearch Whether to search for devices immediately
 */
- (void)startAndSearch:(BOOL)isSearch;


/**
 Search for devices in the LAN
 */
- (void)search;


/**
 Get the discovered devices
 @return DMR Array
 */
- (NSArray<Device *> *)getDeviceList;

@end

NS_ASSUME_NONNULL_END
