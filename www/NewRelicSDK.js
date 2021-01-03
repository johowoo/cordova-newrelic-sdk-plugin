var exec = require('cordova/exec');

var NewRelicSDK = function () {
  this.name = "NewRelicSDK";
};

// IOS SDK APIs
NewRelicSDK.prototype.noticeNetworkRequestForIOS = function (url, httpMethod, timeElapsedInMilliseconds, headers, httpStatusCode, bytesSent, bytesReceived, responseData, success, error) {
  exec(success, error, 'NewRelicSDK', 'noticeNetworkRequestForIOS', [url, httpMethod, timeElapsedInMilliseconds, headers, httpStatusCode, bytesSent, bytesReceived, responseData]);
};

NewRelicSDK.prototype.noticeNetworkRequestFailureForIOS = function (url, httpMethod, timeElapsedInMilliseconds, httpStatusCode, success, error) {
  exec(success, error, 'NewRelicSDK', 'noticeNetworkRequestFailureForIOS', [url, httpMethod, timeElapsedInMilliseconds, httpStatusCode]);
};

NewRelicSDK.prototype.setAttributeForIOS = function (key, value, success, error) {
  exec(success, error, 'NewRelicSDK', 'setAttributeForIOS', [key, value]);
};

NewRelicSDK.prototype.setUserIdForIOS = function (value, success, error) {
  exec(success, error, 'NewRelicSDK', 'setUserIdForIOS', [value]);
};

NewRelicSDK.prototype.crashNowForIOS = function (value, success, error) {
  exec(success, error, 'NewRelicSDK', 'crashNowForIOS', [value]);
};

NewRelicSDK.prototype.incrementAttributeForIOS = function (key, value, success, error) {
  exec(success, error, 'NewRelicSDK', 'incrementAttributeForIOS', [key, value]);
};

NewRelicSDK.prototype.recordCustomEventForIOS = function(eventType, eventName, eventAttributes, success, error) {
  exec(success, error, 'NewRelicSDK', 'recordCustomEventForIOS', [eventType, eventName, eventAttributes]);
}


// Android SDK APIs
NewRelicSDK.prototype.noticeNetworkRequestForAndroid = function (url, method, statusCode, startTimeMs, endTimeMs, bytesSent, bytesReceived, success, error) {
  exec(success, error, 'NewRelicSDK', 'noticeNetworkRequestForAndroid', [url, method, statusCode, startTimeMs, endTimeMs, bytesSent, bytesReceived]);
};

NewRelicSDK.prototype.noticeNetworkRequestFailureForAndroid = function (url, method, startTime, endTime, exceptionString, success, error) {
  exec(success, error, 'NewRelicSDK', 'noticeNetworkRequestFailureForAndroid', [url, method, startTime, endTime, exceptionString]);
};

NewRelicSDK.prototype.setAttributeForAndroid = function (key, value, success, error) {
  exec(success, error, 'NewRelicSDK', 'setAttributeForAndroid', [key, value]);
};

NewRelicSDK.prototype.setUserIdForAndroid = function (value, success, error) {
  exec(success, error, 'NewRelicSDK', 'setUserIdForAndroid', [value]);
};

NewRelicSDK.prototype.crashNowForAndroid = function (value, success, error) {
  exec(success, error, 'NewRelicSDK', 'crashNowForAndroid', [value]);
};

NewRelicSDK.prototype.incrementAttributeForAndroid = function (key,value, success, error) {
  exec(success, error, 'NewRelicSDK', 'incrementAttributeForAndroid', [key, value]);
};

NewRelicSDK.prototype.recordCustomEventForAndroid = function(eventType, eventName, eventAttributes, success, error) {
  exec(success, error, 'NewRelicSDK', 'recordCustomEventForAndroid', [eventType, eventName, eventAttributes]);
}

module.exports = new NewRelicSDK();
