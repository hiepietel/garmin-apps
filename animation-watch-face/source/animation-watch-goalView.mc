import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Application;
import Toybox.Attention;


//https://www.flaticon.com


class animation_watch_goalView extends WatchUi.View {
    
    var i = 1;
    var goalType;

    var bitmap;
    
    var screenWidth = System.getDeviceSettings().screenWidth;
    var screenHeight = System.getDeviceSettings().screenHeight;
    
    
    // function initialize() {
    //     View.initialize();
    // }

    function initialize(achievedGoalType as Application.GoalType ) {
        View.initialize();
        System.println("goalType: " + achievedGoalType);

        goalType = achievedGoalType;
    }

    // Resources are loaded here
    function onLayout(dc) {
        dc.clear();
        setLayout(Rez.Layouts.GoalView(dc));
        
        
        System.println("System.getDeviceSettings().screenWidth: " + System.getDeviceSettings().screenWidth);
        System.println("System.getDeviceSettings().screenHeight: " + System.getDeviceSettings().screenHeight);
        System.println("Application.GOAL_TYPE_STEPS " + Application.GOAL_TYPE_STEPS);

        bitmap = new WatchUi.Bitmap({
            :rezId => Rez.Drawables.FootstepsRedBlue,
            :locX=> -100,
            :locY => -100
        });

        if(goalType == Application.GOAL_TYPE_STEPS) //0
        {
              bitmap.setBitmap(Rez.Drawables.FootstepsRedBlue);  
        }
        else if(goalType == Application.GOAL_TYPE_FLOORS_CLIMBED)
        {
            bitmap.setBitmap(Rez.Drawables.FootstepsRedBlue);  
        }
        else if(goalType == Application.GOAL_TYPE_ACTIVE_MINUTES){
            bitmap.setBitmap(Rez.Drawables.FootstepsRedBlue);  
        }
        else{

        }


    }

    // onShow() is called when this View is brought to the foreground
    function onShow() {

        var bitmapWidth = bitmap.getDimensions()[0];
        var bitmapHeight = bitmap.getDimensions()[1];

        System.println("bitmapWidth: " + bitmapWidth);
        System.println("bitmapHeight: " + bitmapHeight);

        bitmap.locX = screenWidth / 2 - bitmapWidth / 2;
        bitmap.locY = screenHeight / 2 - bitmapHeight / 2;

        //steps_red_blue_bitmap.draw(dc);
    }

    // onUpdate() is called periodically to update the View
    function onUpdate(dc) {
        
        View.onUpdate(dc);

        if(goalType == Application.GOAL_TYPE_STEPS) //0
        {
            if(i % 2 == 0)
            {
                bitmap.setBitmap(Rez.Drawables.FootstepsGreenViolet);
            }
            else
            {
                bitmap.setBitmap(Rez.Drawables.FootstepsRedBlue);   
            }
        }
        else if (goalType == Application.GOAL_TYPE_FLOORS_CLIMBED)
        {
            if(i % 2 == 0)
            {
                bitmap.setBitmap(Rez.Drawables.GoUpstairsBlueOrange);
            }
            else
            {
                bitmap.setBitmap(Rez.Drawables.GoUpstairsGreenViolet);   
            }
        }
        else if(goalType == Application.GOAL_TYPE_ACTIVE_MINUTES)
        {
            if(i % 4 == 0)
            {
                bitmap.setBitmap(Rez.Drawables.AccessibilityGreen);   
            }
            else if(i % 4 == 1)
            {
            bitmap.setBitmap(Rez.Drawables.AccessibilityGreenRed);   
            }
            else if(i % 4 == 2)
            {
                bitmap.setBitmap(Rez.Drawables.AccessibilityRed);   
            }
            else
            {
                bitmap.setBitmap(Rez.Drawables.AccessibilityRedGreen);   
            }
        }
        
        bitmap.draw(dc);
        i++;
    }

    // onHide() is called when this View is removed from the screen
    function onHide() {
    }
}