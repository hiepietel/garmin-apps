import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Activity;

class animation_watch_faceApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        //var goal = Application.getGoalType(Activity.GOAL_TYPE_STEP as Activity.GoalType);
        return getGoalView(Application.GOAL_TYPE_STEPS as Application.GoalType);
        //return [ new animation_watch_faceView() ];
    }

    function getGoalView(goalType as Application.GoalType) as [ WatchUi.View ] or Null {
        return  [new animation_watch_goalView(goalType)];
    }

}

function getApp() as animation_watch_faceApp {
    return Application.getApp() as animation_watch_faceApp;
}