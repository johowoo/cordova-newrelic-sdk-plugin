package cordova.plugins;

import android.util.Log;

import java.util.HashMap;
import java.util.Map;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.newrelic.agent.android.NewRelic;

public class NewRelicSDK extends CordovaPlugin {
    public static final String TAG = "NewRelicSDKAndroid";

    public void noticeNetworkRequestForAndroid(String url, String method, String statusCode, String startTimeMs, String endTimeMs, String bytesSent, String bytesReceived) {
        NewRelic.noticeHttpTransaction(url, method, Integer.parseInt(statusCode), Long.parseLong(startTimeMs), Long.parseLong(endTimeMs), Long.parseLong(bytesSent), Long.parseLong(bytesReceived));
        Log.d("**** successfully called noticeNetworkRequestForAndroid --network-success-- with url: ****", url);
    }

    public void noticeNetworkRequestFailureForAndroid(String url, String method, String startTime, String endTime, String exceptionString) {
        Exception exception = new Exception(exceptionString);
        NewRelic.noticeNetworkFailure(url, method, Long.parseLong(startTime), Long.parseLong(endTime), exception);
        Log.d("**** successfully called noticeNetworkRequestFailureForAndroid --network-failure-- with url: ****", url);
    }

    public void setAttributeForAndroid(String key, String value) {
        NewRelic.setAttribute(key, value);
        Log.d("----- successfully called setAttributeForAndroid with value-key: -----", key + "-" + value);
    }

    public void setUserIdForAndroid(String value) {
        NewRelic.setUserId(value);
        Log.d("----- successfully called setUserIdForAndroid with value: -----", value);
    }

    public void crashNowForAndroid(String value) {
        NewRelic.crashNow(value);
        Log.d("##### successfully called crashNowForAndroid with value: #####", value);
    }

    public boolean incrementAttributeForAndroid(String key, String value) {
        boolean result = NewRelic.incrementAttribute(key, Float.parseFloat(value));
        Log.d("------ successfully called incrementAttributeForAndroid with key-value: -----", key + "-" + value);
        return result;
    }

    public boolean recordCustomEventForAndroid(String eventType, String eventName, String eventAttributesString) {
        Map<String, Object> eventAttributes;
        try {
            eventAttributes = new ObjectMapper().readValue(eventAttributesString, HashMap.class);
        } catch (JsonProcessingException e) {
            Log.e("!!!! failed to convert JSON !!!!", e.getMessage());
            return false;
        }
        boolean result = NewRelic.recordCustomEvent(eventType, eventName, eventAttributes);
        Log.d("------ successfully called recordCustomEventForAndroid with type-name: -----", eventType + "-" + eventName);
        return result;
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callback) throws JSONException {
    	Log.d(TAG, "Executing " + action);
    	 switch (action) {
                	case "noticeNetworkRequestForAndroid":
                	    this.run(() -> {
                	        try{
                	            this.noticeNetworkRequestForAndroid(args.getString(0), args.getString(1), args.getString(2), args.getString(3), args.getString(4), args.getString(5), args.getString(6));
                	        }
                	        catch(JSONException e){
                                Log.e("!!!! failed to convert JSON !!!!", e.getMessage());
                            }
                	    }, callback);
                    	break;

                	case "noticeNetworkRequestFailureForAndroid":
                        this.run(() -> {
                            try{
                                this.noticeNetworkRequestFailureForAndroid(args.getString(0), args.getString(1), args.getString(2), args.getString(3), args.getString(4));
                            }
                            catch(JSONException e){
                                Log.e("!!!! failed to convert JSON !!!!", e.getMessage());
                            }
                        }, callback);
                        break;

                	case "setAttributeForAndroid":
                        this.run(() -> {
                            try{
                                this.setAttributeForAndroid(args.getString(0), args.getString(1));
                            }
                            catch(JSONException e){
                                Log.e("!!!! failed to convert JSON !!!!", e.getMessage());
                            }
                        }, callback);
                        break;

                	case "setUserIdForAndroid":
                        this.run(() -> {
                            try{
                                this.setUserIdForAndroid(args.getString(0));
                            }
                            catch(JSONException e){
                                Log.e("!!!! failed to convert JSON !!!!", e.getMessage());
                            }
                        }, callback);
                        break;

                	case "crashNowForAndroid":
                        this.run(() -> {
                            try{
                                this.crashNowForAndroid(args.getString(0));
                            }
                            catch(JSONException e){
                                Log.e("!!!! failed to convert JSON !!!!", e.getMessage());
                            }
                        }, callback);
                        break;

                	case "incrementAttributeForAndroid":
                        this.run(() -> {
                            try{
                                this.incrementAttributeForAndroid(args.getString(0), args.getString(1));
                            }
                            catch(JSONException e){
                                Log.e("!!!! failed to convert JSON !!!!", e.getMessage());
                            }
                        }, callback);
                        break;

                	case "recordCustomEventForAndroid":
                        this.run(() -> {
                            try{
                                this.recordCustomEventForAndroid(args.getString(0), args.getString(1), args.getString(2));
                            }
                            catch(JSONException e){
                                Log.e("!!!! failed to convert JSON !!!!", e.getMessage());
                            }
                        }, callback);
                        break;

            		default:
            			return false;
                }

        return false;
    }

    private void run(Runnable func, CallbackContext callback) {
            cordova.getThreadPool().execute(new CordovaRunnable(this, callback, func));
    	return;
    }
    
	class CordovaRunnable implements Runnable {
		NewRelicSDK newRelic;
		CallbackContext callback;
		Runnable action;
		
		public CordovaRunnable(NewRelicSDK newRelic, CallbackContext callback, Runnable action) {
			this.newRelic = newRelic;
			this.callback = callback;
			this.action = action;
		}
		
		@Override
		public void run() {
			try {
				this.action.run();
				this.callback.success();
			} catch (Exception e) {
                Log.e(TAG, "Error executing callback method " + e.getMessage());
                this.callback.error(e.getMessage());				
			}
		}
	}    
}
