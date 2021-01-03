# cordova plugin for newrelic native SDK

a cordova plugin for providing direct access to native newrelic SDK APIs

# Installation
```bash
cordova plugin add <path to this project>
eg: 
cordova plugin add ~/Documents/newrelic/cordova-newrelic-sdk-plugin/
```

### Prerequisites
1. [New Relic plugin for Cordova](https://github.com/newrelic/newrelic-cordova-plugin.git)
which is the official plugin from NewRelic. It does not work out of box and have no APIS that can called directly.
So When I was doing the configuration for a Cordova App. I built this plugin so that we can call those APIs directly.

2. There is another way of logging HTTP requests inside a cordova/ionic app. 
which is add the JS configuration code to 'index.html' and check the results within 'browser' instead of mobile;

3. My advice is using both the browser & mobile solution together and use NewRelic analysts to combine them together by using 'setCustomAttributes';

### Usages

```javascript
if(window.NewRelicSDK) {
 // all params are String-typed to avoid conflicts between JS and ObjectiveC/JAVA
  window.NewRelicSDK.noticeNetworkRequestForIOS(
  					requestUrl,
  					method,
  					`${timeElapsedInMilliseconds}`,
  					JSON.stringify(response.headers),
  					`${response.status}`,
  					`${bytesSent}`,
  					`${bytesReceived}`,
  					JSON.stringify(response.data),
  					()=>{/* success callback */ },
  					(e)=>{/* error callback */ }
  				);
}else{
  $log.error("NewRelicSDK not available");
}
```
### Available APIs

#### IOS (NewRelicSDK.*)
```javascript 
 noticeNetworkRequestForIOS(url, httpMethod, timeElapsedInMilliseconds, headers, httpStatusCode, bytesSent, bytesReceived, responseData)
 noticeNetworkRequestFailureForIOS(url, httpMethod, timeElapsedInMilliseconds, httpStatusCode)
 setAttributeForIOS(key, value)
 setUserIdForIOS(value)
 crashNowForIOS(value)
 incrementAttributeForIOS(key, value)
 recordCustomEventForIOS(eventType, eventName, eventAttributes)
```

#### Android (NewRelicSDK.*)
```javascript 
 noticeNetworkRequestForIOS(url, method, statusCode, startTimeMs, endTimeMs, bytesSent, bytesReceived)
 noticeNetworkRequestFailureForIOS(url, method, startTime, endTime, exceptionString)
 setAttributeForIOS(key, value)
 setUserIdForIOS(value)
 crashNowForIOS(value)
 incrementAttributeForIOS(key, value)
 recordCustomEventForIOS(eventType, eventName, eventAttributes)
```
