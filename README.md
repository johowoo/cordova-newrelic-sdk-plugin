# cordova-newrelic-sdk-plugin

a cordova plugin for providing direct access to native newrelic SDK APIs

# Installation
```bash
cordova plugin add cordova-newrelic-sdk-plugin
```

### Prerequisites
1. [New Relic plugin for Cordova](https://github.com/newrelic/newrelic-cordova-plugin.git)
(which is the official plugin from NewRelic. It does not work out-of-box and has no APIs that can be called directly.)

2. There is another way of logging HTTP requests inside a cordova/ionic app. 
which is adding the JS configuration code to the 'index.html' file and checking the results within 'browser' instead of "mobile";

3. My advice is using both the browser & mobile solution and combine them together by using 'setCustomAttributes';

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

#### IOS (window.NewRelicSDK.*)
```javascript 
 noticeNetworkRequestForIOS(url, httpMethod, timeElapsedInMilliseconds, headers, httpStatusCode, bytesSent, bytesReceived, responseData)
 noticeNetworkRequestFailureForIOS(url, httpMethod, timeElapsedInMilliseconds, httpStatusCode)
 setAttributeForIOS(key, value)
 setUserIdForIOS(value)
 crashNowForIOS(value)
 incrementAttributeForIOS(key, value)
 recordCustomEventForIOS(eventType, eventName, eventAttributes)
```

#### Android (window.NewRelicSDK.*)
```javascript 
 noticeNetworkRequestForIOS(url, method, statusCode, startTimeMs, endTimeMs, bytesSent, bytesReceived)
 noticeNetworkRequestFailureForIOS(url, method, startTime, endTime, exceptionString)
 setAttributeForIOS(key, value)
 setUserIdForIOS(value)
 crashNowForIOS(value)
 incrementAttributeForIOS(key, value)
 recordCustomEventForIOS(eventType, eventName, eventAttributes)
```
