using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Lang as Lng;
using Toybox.WatchUi as Ui;
using Toybox.Background;
using Toybox.Time;
using Toybox.Time.Gregorian as GregTime;

(:background)
class PopeTimeApp extends App.AppBase {

    hidden var startFromBackground = false; 

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Lng.Dictionary?) as Void {

        if(Toybox.System has :ServiceDelegate) 
        {
            var now = GregTime.info(Time.now(), Time.FORMAT_MEDIUM);

            var options = {
                :year => now.year, 
                :month => now.month, 
                :day => now.day,
                :hour => now.hour,
                :minute  => now.min + 10
            };

            var popeTimeValue = GregTime.moment(options).value();
            var popeTimeMoment = new Time.Moment(popeTimeValue);

            // if(now.hour >= 21 && now.min >= 37){
            //    var oneDay = new Time.Duration(GregTime.SECONDS_PER_DAY); 
            //    popeTimeMoment.add(oneDay);
            // }

    		Background.registerForTemporalEvent(popeTimeMoment);

            Sys.println(Background.getTemporalEventRegisteredTime());
        }
        else {
    		Sys.println("****background not available on this device****");
    	}


    }

    // onStop() is called when your application is exiting
    function onStop(state as Lng.Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Ui.Views] or [Ui.Views, Ui.InputDelegates] {
        if(startFromBackground == true){
            startFromBackground = false;
            return [new PopeTimeNotificationView()]; 
        }

        return [ new PopeTimeView(), new PopeTimeDelegate() ];
    }

    function onBackgroundData(data) {
        if(data instanceof Lang.Boolean){
            Sys.println(data);
            startFromBackground = true;
        }

        Ui.requestUpdate();
    }

    function getServiceDelegate(){
        return [new PopeTimeServiceDelegate()];
    }

}

function getApp() as PopeTimeApp {
    return App.getApp() as PopeTimeApp;
}