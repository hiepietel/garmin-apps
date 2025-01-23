using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Lang as Lng;
using Toybox.WatchUi as Ui;
using Toybox.Background;
using Toybox.Time;
using Toybox.Time.Gregorian as GregTime;

(:background)
class PopeTimeApp extends App.AppBase {

    //hidden var startFromBackground = false; 

    function initialize() 
    {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Lng.Dictionary?) as Void 
    {
        var creator = new PopeTimeBackgroundServiceCreator();
        creator.create();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Lng.Dictionary?) as Void 
    {
    }

    // Return the initial view of your application here
    function getInitialView() as [Ui.Views] or [Ui.Views, Ui.InputDelegates] 
    {
 
        // if(startFromBackground == true){
        //     startFromBackground = false;
        //     return [new PopeTimeNotificationView()]; 
        // }

        return [ new PopeTimeView(), new PopeTimeDelegate() ];
    }

    function onBackgroundData(data) 
    { 
        // startFromBackground = true;
        // Ui.pushView( new PopeTimeNotificationView(), null, Ui.SLIDE_IMMEDIATE);

       // Ui.requestUpdate();
    }

    function onHide() 
    {
       //startFromBackground = false; 
    }

    function getServiceDelegate()
    {
        return [new PopeTimeServiceDelegate()];
    }

}

function getApp() as PopeTimeApp 
{
    return App.getApp() as PopeTimeApp;
}