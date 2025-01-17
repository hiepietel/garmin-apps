import Toybox.Lang;
import Toybox.System;
using Toybox.WatchUi as Ui;

class PopeTimeMenuDelegate extends Ui.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {
        System.println(item.getId());

        if(item.getId() == "showPopeAnimation"){
            
            // Ui.switchToView( new PopeTimeNotificationView(), null, Ui.SLIDE_IMMEDIATE);
            // Ui.requestUpdate();
            System.println("showPopeAnimation");
        } 
    }

    // function onMenuItem(item as Symbol) as Void {
    //     if (item == :item_1) {
    //         System.println("item 1");
    //     } else if (item == :item_2) {
    //         System.println("item 2");
    //     }
    // }

}