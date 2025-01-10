import Toybox.Lang;
import Toybox.WatchUi;

class simple_device_appDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SimpleDeviceAppMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}