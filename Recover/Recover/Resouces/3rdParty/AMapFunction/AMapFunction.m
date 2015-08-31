//
//  AMapFunction.m
//  BabySante
//
//  Created by YangXudong on 15/5/12.
//  Copyright (c) 2015年 Amesante. All rights reserved.
//

#define AMapFunctionInstance                [AMapFunction sharedInstance]
#define AMapFunctionInstanceMapView         [AMapFunction sharedInstance].mapView
#define AMapFunctionInstanceSearchApi       [AMapFunction sharedInstance].searchApi

#import "AMapFunction.h"
#import <AMapSearchAPI.h>
#import <MAMapKit/MAMapKit.h>

@interface AMapFunction ()<MAMapViewDelegate,AMapSearchDelegate>

/**
 *  地图实例
 */
@property (nonatomic, strong) MAMapView *mapView;

/**
 *  搜索实例
 */
@property (nonatomic, strong) AMapSearchAPI *searchApi;

/**
 *  获取用户经纬度后执行的方法
 */
@property (nonatomic, copy) AMapFunctionBlockUserLocation blockUserLocation;

/**
 *  获取用户经纬度和地理位置后执行的方法
 */
@property (nonatomic, copy) AMapFunctionBlockUserLocationAndCity blockUserLocationAndCity;

/**
 *  获取用户搜索结果后执行的方法
 */
@property (nonatomic, copy) AMapFunctionBlockSearchResult blockSearchResult;

/**
 *  获取用户经纬度失败后执行的方法
 */
@property (nonatomic, copy) AMapFunctionBlockFailure blockUserLocationFailure;

/**
 *  获取用户搜索结果失败后执行的方法
 */
@property (nonatomic, copy) AMapFunctionBlockFailure blockSearchResultFailure;

@end

@implementation AMapFunction

#pragma mark -

+(void)action_getUserLocationAndCityWithBlock:(AMapFunctionBlockUserLocationAndCity)block failure:(AMapFunctionBlockFailure)failure{
    AMapFunctionInstance.blockUserLocationAndCity = block;
    AMapFunctionInstance.blockUserLocationFailure = failure;
    AMapFunctionInstance.blockSearchResultFailure = failure;
    [AMapFunction action_showUserLocation:YES];
}





#pragma mark - Delegates

//位置更新
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if (updatingLocation) {
        
        CLLocationCoordinate2D location = userLocation.location.coordinate;
        
        NSString *lat = [NSString stringWithFormat:@"%lf",location.latitude];
        NSString *lon = [NSString stringWithFormat:@"%lf",location.longitude];
        
        if (AMapFunctionInstance.blockUserLocation) {
            AMapFunctionInstance.blockUserLocation(lat,lon);
        }
        
        if (AMapFunctionInstance.blockUserLocationAndCity) {
            [AMapFunction action_searchAddressWithLatitude:lat longtitude:lon];
        }
        
        [AMapFunction action_showUserLocation:NO];
    }
}

//定位失败
-(void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    if (AMapFunctionInstance.blockUserLocationFailure) {
        AMapFunctionInstance.blockUserLocationFailure();
    }
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        if (self.blockUserLocationAndCity) {
            
            NSString *lat = [NSString stringWithFormat:@"%lf",request.location.latitude];
            NSString *lon = [NSString stringWithFormat:@"%lf",request.location.longitude];
            NSString *city = response.regeocode.addressComponent.province;
            
            if (response.regeocode.addressComponent.city.length) {
                city = [city stringByAppendingString:response.regeocode.addressComponent.city];
            }
            
            self.blockUserLocationAndCity(lat,lon,city);
        }
    } else {
        [self searchRequest:request didFailWithError:nil];
    }
}

//搜索失败
- (void)searchRequest:(id)request didFailWithError:(NSError *)error {
    if (AMapFunctionInstance.blockSearchResultFailure) {
        AMapFunctionInstance.blockSearchResultFailure();
    }
}

#pragma mark - Utils

+ (void) action_showUserLocation:(BOOL)showLocation {
    AMapFunctionInstanceMapView.showsUserLocation = showLocation;
}

+ (void) action_searchAddressWithLatitude:(NSString *)latitude
                               longtitude:(NSString *)longtitude {
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.searchType = AMapSearchType_ReGeocode;
    regeoRequest.location = [AMapGeoPoint locationWithLatitude:[latitude doubleValue] longitude:[longtitude doubleValue]];
    
    //发起逆地理编码
    [AMapFunctionInstanceSearchApi AMapReGoecodeSearch:regeoRequest];
}

#pragma mark - Instance Init

+ (AMapFunction *) sharedInstance {

    static AMapFunction *amapFunction = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [MAMapServices sharedServices].apiKey = AMap_Key;
        
        amapFunction = [AMapFunction new];
        
        amapFunction.mapView = [MAMapView new];
        amapFunction.mapView.delegate = amapFunction;
        
        amapFunction.searchApi = [[AMapSearchAPI alloc] initWithSearchKey:AMap_Key Delegate:amapFunction];
    });
    
    return amapFunction;
}

@end
