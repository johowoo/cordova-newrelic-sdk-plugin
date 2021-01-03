# cordova plugin for newrelic native SDK

Provides javascript interface in order to call New Relic SDK on both IOS & Android

# Installation
cordova plugin add <xxx>

### Prerequisites
1. [New Relic plugin for Cordova](https://github.com/newrelic/newrelic-cordova-plugin.git)

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
1. noticeNetworkRequestForIOS(url, httpMethod, timeElapsedInMilliseconds, headers, httpStatusCode, bytesSent, bytesReceived, responseData)
2. noticeNetworkRequestFailureForIOS(url, httpMethod, timeElapsedInMilliseconds, httpStatusCode)
3. setAttributeForIOS(key, value)
4. setUserIdForIOS(value)
5. crashNowForIOS(value)
6. incrementAttributeForIOS(key, value)
7. recordCustomEventForIOS(eventType, eventName, eventAttributes)

#### Android (NewRelicSDK.*)
1. noticeNetworkRequestForIOS(url, method, statusCode, startTimeMs, endTimeMs, bytesSent, bytesReceived)
2. noticeNetworkRequestFailureForIOS(url, method, startTime, endTime, exceptionString)
3. setAttributeForIOS(key, value)
4. setUserIdForIOS(value)
5. crashNowForIOS(value)
6. incrementAttributeForIOS(key, value)
7. recordCustomEventForIOS(eventType, eventName, eventAttributes)
