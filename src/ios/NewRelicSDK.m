/********* NewRelicSDK Cordova IOS Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <NewRelicAgent/NewRelic.h>

@interface NewRelicSDK : CDVPlugin {
  // Member variables go here.
}

@end

@implementation NewRelicSDK
- (void)noticeNetworkRequestForIOS:(CDVInvokedUrlCommand*)command
{
    NSLog(@"***** calling newrelic API noticeNetworkRequestForURL ---network-success--- *****");
    CDVPluginResult* pluginResult = nil;
    NSString* urlString = [command.arguments objectAtIndex:0];
    NSString* httpMethodString = [command.arguments objectAtIndex:1];
    NSString* timeElapsedInMilliString = [command.arguments objectAtIndex:2];
    NSString* headersString = [command.arguments objectAtIndex:3];
    NSString* statusCodeString = [command.arguments objectAtIndex:4];
    NSString* bytesSentString = [command.arguments objectAtIndex:5];
    NSString* bytesReceivedString = [command.arguments objectAtIndex:6];
    NSString* responseDataString = [command.arguments objectAtIndex:7];
    
    // type conversion
    NSURL* url = [NSURL URLWithString:urlString];
    NSString* httpMethod = httpMethodString;
    NSDictionary *headers = [NSJSONSerialization JSONObjectWithData:[headersString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    NSInteger statusCode = statusCodeString.intValue;
    NSUInteger bytesSent = (NSUInteger)bytesSentString.intValue;
    NSUInteger bytesReceived = (NSUInteger)bytesReceivedString.intValue;
    NSData * responseData = [responseDataString dataUsingEncoding:NSUTF8StringEncoding];
    double timesElapsedInMilliseconds= (double)timeElapsedInMilliString.intValue;

    // a 'setTimeout' to for calculating timeElapsed for the API call
    NRTimer* timer = [NRTimer new];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timesElapsedInMilliseconds/1000 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [timer stopTimer];
        [NewRelic noticeNetworkRequestForURL:url httpMethod:httpMethod withTimer:timer responseHeaders:headers statusCode:statusCode bytesSent:bytesSent bytesReceived:bytesReceived responseData:responseData andParams:NULL];
        NSLog(@"***** successfully called Newrelic noticeNetworkRequestForIOS ---network-success--- *****");
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    });
}
- (void)noticeNetworkRequestFailureForIOS:(CDVInvokedUrlCommand*)command
{
    NSLog(@"***** calling newrelic API noticeNetworkFailureForURL ---network-failure--- *****");
    CDVPluginResult* pluginResult = nil;
    NSString* urlString = [command.arguments objectAtIndex:0];
    NSString* httpMethodString = [command.arguments objectAtIndex:1];
    NSString* timeElapsedInMilliString = [command.arguments objectAtIndex:2];
    NSString* statusCodeString = [command.arguments objectAtIndex:3];

    // type conversion
    NSURL* url = [NSURL URLWithString:urlString];
    NSString* httpMethod = httpMethodString;
    NSInteger statusCode = statusCodeString.intValue;
    double timesElapsedInMilliseconds= (double)timeElapsedInMilliString.intValue;

    // a 'setTimeout' to for calculating timeElapsed for the API call
    NRTimer* timer = [NRTimer new];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timesElapsedInMilliseconds/1000 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [timer stopTimer];
        [NewRelic noticeNetworkFailureForURL:url httpMethod:httpMethod withTimer:timer  andFailureCode:statusCode];
        NSLog(@"***** successfully called Newrelic noticeNetworkFailureForURL ---network-failure--- *****");
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    });
}
- (void)setAttributeForIOS:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* key = [command.arguments objectAtIndex:0];
    NSString* value = [command.arguments objectAtIndex:1];
    NSLog(@"----- calling newrelic API setAttributeForIOS -----");

    if (key != nil && [key length] > 0) {
        BOOL attributeSet = [NewRelic setAttribute:key value:value];
        NSLog(attributeSet ? @"---- successfully called Newrelic setAttributeForIOS ----" : @"!!!! setAttributeForIOS Failed !!!!");
        if (attributeSet) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void)setUserIdForIOS:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* value = [command.arguments objectAtIndex:0];
    NSLog(@"----- calling newrelic API setUserIdForIOS -----");

    if (value != nil && [value length] > 0) {
        BOOL userIdSet = [NewRelic setUserId:value];
        NSLog(userIdSet ? @"---- successfully called Newrelic setUserIdForIOS ----" : @"!!!! setUserIdForIOS Failed !!!!");
        if (userIdSet) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)crashNowForIOS:(CDVInvokedUrlCommand*)command
{
    NSLog(@"#### calling newrelic API crashNowForIOS ####");
    CDVPluginResult* pluginResult = nil;
    NSString* crashString = [command.arguments objectAtIndex:0];

    [NewRelic crashNow:crashString];
    NSLog(@"#### successfully called Newrelic crashNowForIOS ####");

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (BOOL)incrementAttributeForIOS:(CDVInvokedUrlCommand*)command
{
    NSLog(@"----- calling newrelic API incrementAttributeForIOS -----");
    CDVPluginResult* pluginResult = nil;
    NSString* keyString = [command.arguments objectAtIndex:0];
    NSString* valueString = [command.arguments objectAtIndex:1];

    // type conversion
    NSInteger valueNumber = valueString.intValue;
    NSNumber *val = [NSNumber numberWithInteger:valueNumber];

    BOOL result = [NewRelic incrementAttribute:keyString value:val];

    NSLog(@"----- successfully called Newrelic incrementAttributeForIOS  -----");
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    return result;
}

-(BOOL)recordCustomEventForIOS:(CDVInvokedUrlCommand*)command
{
    NSLog(@"----- calling newrelic API recordCustomEventForIOS -----");
    CDVPluginResult* pluginResult = nil;
    NSString* eventTypeString = [command.arguments objectAtIndex:0];
    NSString* eventNameString = [command.arguments objectAtIndex:1];
    NSString* eventAttributesString = [command.arguments objectAtIndex:2];

    // type conversion
    NSDictionary *eventAttributes = [NSJSONSerialization JSONObjectWithData:[eventAttributesString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];

    BOOL result = [NewRelic recordCustomEvent:eventTypeString name:eventNameString attributes:eventAttributes];

    NSLog(@"----- successfully called Newrelic recordCustomEventForIOS  -----");
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    return result;
}

@end
