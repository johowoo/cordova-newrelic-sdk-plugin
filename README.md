# cordova plugin used for calling newrelic SDK APIs directly from JavaScript

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
