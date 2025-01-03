import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Application;


//https://www.flaticon.com


class animation_watch_goalView extends WatchUi.View {
    
    var i = 0;
    var goalType ;

    var steps_red_blue_bitmap;
    var steps_green_violet_bitmap ;
    
    var screenWidth = System.getDeviceSettings().screenWidth;
    var screenHeight = System.getDeviceSettings().screenHeight;
    
    
    // function initialize() {
    //     View.initialize();
    // }

    function initialize(goalType as Application.GoalType ) {
        View.initialize();
        System.println("goalType: " + goalType);

        goalType = goalType;
    }

    // Resources are loaded here
    function onLayout(dc) {
        dc.clear();
        setLayout(Rez.Layouts.GoalView(dc));
        
        
        System.println("System.getDeviceSettings().screenWidth: " + System.getDeviceSettings().screenWidth);
        System.println("System.getDeviceSettings().screenHeight: " + System.getDeviceSettings().screenHeight);

        steps_red_blue_bitmap = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.footsteps_red_blue,
            :locX=> -100,
            :locY => -100
        });

        steps_green_violet_bitmap = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.fotsteps_green_violet,
                        :locX=> -100,
            :locY => -100
        });
    }

    // onShow() is called when this View is brought to the foreground
    function onShow() {

        var bitmapWidth = steps_red_blue_bitmap.getDimensions()[0];
        var bitmapHeight = steps_red_blue_bitmap.getDimensions()[1];

        steps_red_blue_bitmap.locX = screenWidth / 2 - bitmapWidth / 2;
        steps_red_blue_bitmap.locY = screenHeight / 2 - bitmapHeight / 2;

        //steps_red_blue_bitmap.draw(dc);    
    }

    // onUpdate() is called periodically to update the View
    function onUpdate(dc) {
        
        dc.clear();
        dc
        if(i % 2 == 0){
            var bitmapWidth = steps_red_blue_bitmap.getDimensions()[0];
            var bitmapHeight = steps_red_blue_bitmap.getDimensions()[1];

            steps_red_blue_bitmap.locX = screenWidth / 2 - bitmapWidth / 2;
            steps_red_blue_bitmap.locY = screenHeight / 2 - bitmapHeight / 2;

            steps_red_blue_bitmap.draw(dc);

            
        }
        else
        {
            var bitmapWidth = steps_green_violet_bitmap.getDimensions()[0];
            var bitmapHeight = steps_green_violet_bitmap.getDimensions()[1];

            steps_green_violet_bitmap.locX = screenWidth / 2 - bitmapWidth / 2;
            steps_green_violet_bitmap.locY = screenHeight / 2 - bitmapHeight / 2;

            steps_green_violet_bitmap.draw(dc);
        }
        i++;
    }

    // onHide() is called when this View is removed from the screen
    function onHide() {
    }
}