//
//  HRUserAFNetworkingModule.m
//  Haru
//
//  Created by SSangGA on 2017. 4. 7..
//  Copyright © 2017년 jcy. All rights reserved.
//

#import "HRUserAFNetworkingModule.h"
#import <AFNetworking/AFNetworking.h>
#import "HRNetworkModule.h"
#import "HRConstantKeys.h"

@interface HRUserAFNetworkingModule ()
@property (nonatomic) AFHTTPSessionManager *manager;
@property (nonatomic) HRNetworkModule *networkModule;

@end

@implementation HRUserAFNetworkingModule


//login 메소드
- (void)loginRequest:(NSString *)username password:(NSString *)password completion:(CompletionBlock)completion
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", BASIC_URL, LOGIN_URL];
    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys:@"username",username,@"password",password, nil];
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"LOGIN RESPONSE:%@", responseObject);
        completion(YES,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"LOGIN ERROR:%@", error);
    }];
}

//logout 메소드
- (void)logoutRequest:(NSString *)token completion:(ResponseBlock)completion
{
    NSString *value = [NSString stringWithFormat:@"%@ %@",@"Token",token];
    NSDictionary *headers = @{ @"authorization": value,
                               @"cache-control": @"no-cache"
                               };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://haru-eb.ap-northeast-2.elasticbeanstalk.com/logout/"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        completion(NO,nil);
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        completion(YES,httpResponse);
                                                        NSLog(@"%@", httpResponse);
                                                    }
                                                }];
    [dataTask resume];
    
    ///*NSURLSessionConfiguration 설정*/
    //NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //
    ///*AFHTTPSessionManager 설정*/
    //self.afhttpSessionManager = [[AFHTTPSessionManager manager] initWithSessionConfiguration:configuration];
    //
    //self.afhttpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    //NSString *url = [NSString stringWithFormat:@"%@%@", BASIC_URL, LOGOUT_URL];
    //
    //[self.afhttpSessionManager.requestSerializer setValue:[@"Token " stringByAppendingString:[HRDataCenter sharedInstance].userToken] forHTTPHeaderField:TOKEN_KEY];
    //
    //[self.afhttpSessionManager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //
    //    completion(YES,responseObject);
    //    NSLog(@"LOGOUT RESPONSE:%@", responseObject);
    //} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //    NSLog(@"LOGOUT ERROR:%@", error);
    //}];
}



//UserID요청하는 메소드
- (void)getUserProfile:(CompletionBlock)completion 
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self.manager = [[AFHTTPSessionManager manager] initWithSessionConfiguration:configuration];
    
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%@%@", BASIC_URL2, USER_URL];
    
    [self.manager.requestSerializer setValue:[@"Token " stringByAppendingString:[HRDataCenter sharedInstance].userToken] forHTTPHeaderField:TOKEN_KEY];
    NSLog(@"url = %@",url);    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(YES, responseObject);
        NSLog(@"UserID RESPONSE:%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"UserID ERROR:%@", error);
    }];
}

//postlist요청하는 메소드
- (void)postListRequest:(NSString *)token completion
                       :(CompletionBlock)completion
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self.manager = [[AFHTTPSessionManager manager] initWithSessionConfiguration:configuration];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
//    NSString *url = [NSString stringWithFormat:@"%@%@", BASIC_URL, POST_URL];
    NSString *url = [NSString stringWithFormat:@"https://haru.ycsinabro.com/post/"];
    
    [self.manager.requestSerializer setValue:[@"Token " stringByAppendingString:[HRDataCenter sharedInstance].userToken] forHTTPHeaderField:TOKEN_KEY];
    NSString *tokenValue = [NSString stringWithFormat:@"%@",[HRDataCenter sharedInstance].userToken];
    NSLog(@"tokenValue = %@",tokenValue);
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"POSTLIST DATA:%@", responseObject);
        completion(YES, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"POSTLIST ERROR:%@", error);
        completion(NO,nil);
    }];
}

//프로파일 이미지 요청 메소드
//- (void)profileImageRequest:(NSString)
@end
