import Toybox.Lang;
import Toybox.WatchUi;

using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian;

class SimpleDeviceAppDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean 
    {

        var nextPopeNotificationTimeValue = new Time.Moment(Background.getTemporalEventRegisteredTime().value());

        var info = Gregorian.utcInfo(nextPopeNotificationTimeValue, Time.FORMAT_SHORT);

        var formatedDate = Lang.format("$1$-$2$-$3$ $4$:$5$", [
            info.year.format("%04u"),
            info.month.format("%02u"),
            info.day.format("%02u"),
            info.hour.format("%02d"),
            info.min.format("%02d")
        ]);

        var menu = new Ui.Menu();
        menu.setTitle("Settings");
        menu.addItem(formatedDate, :item_1);

        Ui.pushView(menu, new SimpleDeviceAppMenuDelegate(), WatchUi.SLIDE_UP);
        
        return true;
    }

}