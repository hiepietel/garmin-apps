import Toybox.Lang;

using Toybox.Background;
using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian as GregTime;

class PopeTimeDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {

        var menu = new WatchUi.Menu2({:title=>"JP II Settings"});

        if(Background.getTemporalEventRegisteredTime() != null){
            var lastPopeNotificationTimeValue = Background.getTemporalEventRegisteredTime().value();
            menu.addItem(
                new MenuItem(
                    "next notification time",
                    ParseNumberDateToDateTimeString(lastPopeNotificationTimeValue),
                    "getTemporalEventRegisteredTime",
                    {}
                )
            );
        }

        if(Background.getLastTemporalEventTime() != null){
            var lastPopeNotificationTimeValue = Background.getLastTemporalEventTime().value();
            menu.addItem(
                new MenuItem(
                    "last notification time",
                    ParseNumberDateToDateTimeString(lastPopeNotificationTimeValue),
                    "getLastTemporalEventTime",
                    {}
                )
            );
        }

        if(Background.getTemporalEventRegisteredTime() != null){
            var now = Time.now().value();
            var future = Background.getTemporalEventRegisteredTime().value();


            var difference = Lang.format("$1$", [(future - now)/60]);
            // var difference = Lang.format("$1$-", future - now);
            menu.addItem(
                new MenuItem(
                    "minutes to next notification",
                    difference,
                    "difference",
                    {}
                )
            );
        }
        //item.setIcon(Rez.Drawables.LauncherIcon); sincle API 3.4.0

        WatchUi.pushView(menu, new PopeTimeMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    function onSelect()
    {
        Ui.pushView( new PopeTimeNotificationView(), null, Ui.SLIDE_IMMEDIATE);
        return true;
    }


   private function ParseNumberDateToDateTimeString(number){
        
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