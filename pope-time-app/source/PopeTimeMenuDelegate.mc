import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class PopeTimeMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        System.println(item.getId());
    }

    // function onMenuItem(item as Symbol) as Void {
    //     if (item == :item_1) {
    //         System.println("item 1");
    //     } else if (item == :item_2) {
    //         System.println("item 2");
    //     }
    // }

}