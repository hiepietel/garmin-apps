using Toybox.Time;
using Toybox.Time.Gregorian as GregTime;
using Toybox.Background;
using Toybox.System as Sys;

(:background)
class PopeTimeBackgroundServiceCreator {

    function create(){
        if(Toybox.System has :ServiceDelegate) 
        {
            var now = System.getClockTime();
            now.sec = 0;
            var duration = new Time.Duration(5 * 60);

            if(now.hour < 21 || (now.hour == 21 && now.min < 32) ){
                var hours = 21 - now.hour;
                var minutes = 37 - now.min;
                duration = new Time.Duration(hours * GregTime.SECONDS_PER_HOUR + minutes * GregTime.SECONDS_PER_MINUTE);
            }   
            else if(now.hour == 21 && now.min >= 32 && now.min < 37){
                return; //cannot create background event 5 minut before the execution
            }
            else if(now.hour >= 22 || (now.hour == 21 && now.min >= 37))
            {
               var hours = 21 - now.hour;
               var minutes = 37 - now.min;
               duration = new Time.Duration(GregTime.SECONDS_PER_DAY + hours * GregTime.SECONDS_PER_HOUR + minutes * GregTime.SECONDS_PER_MINUTE);
            }
            
            var timeNow = Time.now();
            var eventTime = timeNow.add(duration);
            var eventTimeWithoutSeconds = new Time.Moment(eventTime.value() - eventTime.value() % GregTime.SECONDS_PER_MINUTE - GregTime.SECONDS_PER_MINUTE / 4);
            
            if(Background.getTemporalEventRegisteredTime() != null && Background.getTemporalEventRegisteredTime() == eventTimeWithoutSeconds)
            {
                return;
            }
            
    		Background.registerForTemporalEvent(eventTimeWithoutSeconds);
        }
        else {
    		Sys.println("****background not available on this device****");
    	}
    }

}