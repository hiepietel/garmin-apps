//import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Background;
//import Toybox.System;

using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Lang;
using Toybox.WatchUi as Ui;
using Toybox.Background;

using Toybox.Time;
using Toybox.Time.Gregorian;

var counter=0;
var bgdata="none";
var canDoBG=false;
var inBackground=false;			//new 8-27
// keys to the object store data
var OSCOUNTER="oscounter";
var OSDATA="osdata";

(:background)
class simple_device_appApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();

        var now=Sys.getClockTime();
    	var ts=now.hour+":"+now.min.format("%02d");
    	//you'll see this gets called in both the foreground and background        
        Sys.println("App initialize "+ts);
        var temp=App.getApp().getProperty(OSCOUNTER);
        //var temp=null;
        if(temp!=null && temp instanceof Number) {counter=temp;}
        Sys.println("Counter in App initialize: "+counter);   


    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {

        Sys.println("onStart");   
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
            	//moved from onHide() - using the "is this background" trick
    	if(!inBackground) {
	    	var now=Sys.getClockTime();
    		var ts=now.hour+":"+now.min.format("%02d");        
        	Sys.println("onStop counter="+counter+" "+ts);    
    		App.getApp().setProperty(OSCOUNTER, counter);     
    	} else {
    		Sys.println("onStop");
    	}
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {	
        Sys.println("getInitialView");

		//register for temporal events if they are supported
    	if(Toybox.System has :ServiceDelegate) {
    		canDoBG=true;

            var timeNow = Time.now();
            var now = Gregorian.info(timeNow, Time.FORMAT_MEDIUM);

            var options = {
                :year => now.year, 
                :month => now.month, 
                :day => now.day,
                :hour => 21,
                :minute  => 37 
            };

            var popeTimeValue = Gregorian.moment(options).value();
            var popeTimeMoment = new Time.Moment(popeTimeValue);

            if(now.hour>= 21 && now.min >= 37){
               var oneDay = new Time.Duration(Gregorian.SECONDS_PER_DAY); 
               popeTimeMoment.add(oneDay);
            }

            Sys.println("now: " + now);
            Sys.println("popeTimeValue: " + popeTimeValue);
            Sys.println("popeTimeMoment: " + popeTimeMoment);

    		Background.registerForTemporalEvent(popeTimeMoment);
            
    	} else {
    		Sys.println("****background not available on this device****");
    	}

        return [ new simple_device_appView(), new SimpleDeviceAppDelegate() ];
    }

    function onBackgroundData(data) {
    	counter++;
    	var sysClockTime=Sys.getClockTime();
    	var ts=sysClockTime.hour+":"+sysClockTime.min.format("%02d");
        Sys.println("onBackgroundData="+data+" "+counter+" at "+ts);
        bgdata=data;

        var alert = new SimpleDeviceAppAlert();

        alert.pushView(Ui.SLIDE_IMMEDIATE);

        var lastExecutionTime = Background.getLastTemporalEventTime();
        Sys.println("lastExecutionTime= " +lastExecutionTime);

        Background.deleteTemporalEvent();

        var timeNow = Time.now();
        var now = Gregorian.info(timeNow, Time.FORMAT_MEDIUM);

        var options = {
            :year => now.year, 
            :month => now.month, 
            :day => now.day,
            :hour => 21,
            :minute  => 37 
        };

        var georgitanTime = Gregorian.moment(options);
        var popeTimeValue = Gregorian.moment(options).value();
        var popeTimeMoment = new Time.Moment(popeTimeValue);

        var timezone = new Time.Duration(sysClockTime.timeZoneOffset);;
        popeTimeMoment.add(timezone);

        if(now.hour>= 21 && now.min >= 37){
            var oneDay = new Time.Duration(Gregorian.SECONDS_PER_DAY); 
            popeTimeMoment.add(oneDay);
        }
        Sys.println("georgitanTime: " + georgitanTime);
        Sys.println("now: " + now);
        Sys.println("popeTimeValue: " + popeTimeValue);
        Sys.println("popeTimeMoment: " + popeTimeMoment);
        Sys.println("timezone: " + timezone);

        Background.registerForTemporalEvent(popeTimeMoment);


        Ui.requestUpdate();
    }

    function getServiceDelegate(){
    	var now=Sys.getClockTime();
    	var ts=now.hour+":"+now.min.format("%02d");    
    	Sys.println("getServiceDelegate: "+ts);
        return [new SimpleDeviceAppBackgroundServiceDelegate()];
    }


    function onAppInstall() {
    	Sys.println("onAppInstall");
    }
    
    function onAppUpdate() {
    	Sys.println("onAppUpdate");
    }

}

function getApp() as simple_device_appApp {
    return App.getApp() as simple_device_appApp;
}