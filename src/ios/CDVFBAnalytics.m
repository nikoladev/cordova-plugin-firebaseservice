#import "CDVFBAnalytics.h"
#import <FirebaseAnalytics/FirebaseAnalytics.h>
@import FirebaseAnalytics;

@implementation CDVFBAnalytics

- (void)init:(CDVInvokedUrlCommand*)command
{
    [FIRApp configure];
}

- (void)setUserProperty:(CDVInvokedUrlCommand*)command
{
    if (command.arguments.count > 1) {
        [self.commandDelegate runInBackground:^{
            NSString* key = [command.arguments objectAtIndex:0];
            NSString* value = [command.arguments objectAtIndex:0];

            [FIRAnalytics setUserPropertyString:key forName:value];

            CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    } else {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid number of parameters"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)logEvent:(CDVInvokedUrlCommand*)command
{
    if (command.arguments.count > 1) {
        [self.commandDelegate runInBackground:^{
            NSString* key = [command.arguments objectAtIndex:0];
            NSArray* logs = command.arguments[1];

            for (int i=0; i<logs.count; i++)
                [FIRAnalytics logEventWithName: key parameters: logs[i]];

            CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    } else {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid number of parameters"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

@end
