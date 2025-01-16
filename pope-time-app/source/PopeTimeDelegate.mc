import Toybox.Lang;

using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian as GregTime;

class PopeTimeDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {


        var nextPopeNotificationTimeValue = Background.getTemporalEventRegisteredTime().value();
        var lastPopeNotificationTimeValue = Background.getLastTemporalEventTime().value();

        var menu = new WatchUi.Menu2({:title=>"JP II Settings"});

        menu.addItem(
            new MenuItem(
                "next notification time",
                ParseNumberDateToDateTimeString(nextPopeNotificationTimeValue),
                "getTemporalEventRegisteredTime",
                {}
            )
        );
        menu.addItem(
            new MenuItem(
                "last notification time",
                ParseNumberDateToDateTimeString(lastPopeNotificationTimeValue),
                "getLastTemporalEventTime",
                {}
            )
        );

        WatchUi.pushView(menu, new PopeTimeMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

   function ParseNumberDateToDateTimeString(number){
        
        var timeValue = new Time.Moment(number);
        var info = GregTime.utcInfo(timeValue, Time.FORMAT_SHORT);

        var formattedDate = Lang.format("$1$-$2$-$3$ $4$:$5$", [
            info.year.format("%04u"),
            info.month.format("%02u"),
            info.day.format("%02u"),
            info.hour.format("%02d"),
            info.min.format("%02d")
        ]);

        return formattedDate;
   }
}