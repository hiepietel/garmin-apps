import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;

class simple_watch_faceView extends WatchUi.WatchFace {
  function initialize() {
    WatchFace.initialize();
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    setLayout(Rez.Layouts.WatchFace(dc));
  }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {}

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Get and show the current time
    var clockTime = System.getClockTime();
    // var timehourString = Lang.format("$1$$2$", [
    //   clockTime.hour.format("%02d"),
    //   clockTime.min.format("%02d"),
    // ]);
    
   // var timeHourString = Lang.format(clockTime.hour.format("%02d"));

    var timeHourLabel = View.findDrawableById("TimeHourLabel") as Text;
    timeHourLabel.setText(clockTime.hour.format("%02d"));
    
    var timeMinuteLabel = View.findDrawableById("TimeMinuteLabel") as Text;
    timeMinuteLabel.setText(clockTime.min.format("%02d"));

    var dateLabel = View.findDrawableById("DateLabel") as Text;
    dateLabel.setText(getDate());

    var heartRateLabel = View.findDrawableById("HeartRateLabel") as Text;
    heartRateLabel.setText(getHeartRateString());

    var stepsLabel = View.findDrawableById("StepsLabel") as Text;
    stepsLabel.setText(getStepsString());

    var batteryLabel = View.findDrawableById("BatteryLabel") as Text;
    batteryLabel.setText(getBatteryString());
    
    var floorsClimbed = View.findDrawableById("FloorsClimbedLabel") as Text;
    floorsClimbed.setText(getFloorsString());

    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);


    // dc.drawText(
    //     dc.getWidth() / 2,                      // gets the width of the device and divides by 2
    //     dc.getHeight() / 2,                     // gets the height of the device and divides by 2
    //     Graphics.FONT_LARGE,                    // sets the font size
    //     timeString,                          // the String to display
    //     Graphics.TEXT_JUSTIFY_CENTER            // sets the justification for the text
    //             );

        var WIDTH = dc.getWidth();
        var HEIGHT = dc.getHeight();

    var ARCLENGTH = 150;
    var ARCWIDTH = 10;
    dc.setPenWidth(ARCWIDTH);


    // if (getBodyBattery() != null) {
    //     dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
    //     dc.drawArc(WIDTH / 2, HEIGHT / 2, HEIGHT / 2 - ARCWIDTH / 2, Graphics.ARC_CLOCKWISE, 180 + ARCLENGTH / 2, 180 + ARCLENGTH / 2 - ARCLENGTH * getStepsRatioThresholded() / 100);
    // }

    // Draw Steps Arc
    dc.setColor(Graphics.COLOR_DK_RED, Graphics.COLOR_TRANSPARENT);
    dc.drawArc(WIDTH / 2, HEIGHT / 2, HEIGHT / 2 - ARCWIDTH / 2, Graphics.ARC_COUNTER_CLOCKWISE, 0 - ARCLENGTH / 2, 0 + ARCLENGTH / 2);

    dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
    dc.drawArc(WIDTH / 2, HEIGHT / 2, HEIGHT / 2 - ARCWIDTH / 2, Graphics.ARC_CLOCKWISE, 180 + ARCLENGTH / 2, 180 - ARCLENGTH / 2);



    if (getSteps() != null && getSteps() > 0 && getStepGoal() != null) {
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawArc(WIDTH / 2, HEIGHT / 2, HEIGHT / 2 - ARCWIDTH / 2, Graphics.ARC_COUNTER_CLOCKWISE, 0 - ARCLENGTH / 2, 0 - ARCLENGTH / 2 + ARCLENGTH * getStepsRatioThresholded());

        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        dc.drawArc(WIDTH / 2, HEIGHT / 2, HEIGHT / 2 - ARCWIDTH / 2, Graphics.ARC_CLOCKWISE, 180 + ARCLENGTH / 2, 180 + ARCLENGTH / 2 - ARCLENGTH * getStepsRatioThresholded());
    }


    WIDTH = dc.getWidth();
    
    HEIGHT = dc.getHeight();

//ARCWIDTH

    dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
    dc.drawArc(WIDTH / 2, HEIGHT / 2, HEIGHT / 2 - ARCWIDTH / 2 - 15, Graphics.ARC_CLOCKWISE, 180 + ARCLENGTH / 2, 180 - ARCLENGTH / 2);
  }
  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  // The user has just looked at their watch. Timers and animations may be started here.
  function onExitSleep() as Void {}

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {}

  function getDate() as String {
    var now = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
    var dateString = Lang.format("$1$ $2$ $3$", [
      now.day_of_week,
      now.day,
      now.month,
    ]);
    return dateString;
  }

  function getHeartRate() as Number {
    var heartrateIterator = Toybox.ActivityMonitor.getHeartRateHistory(1, true);
    return heartrateIterator.next().heartRate;
  }

  function getHeartRateString() as String {
    return getHeartRate().format("%d");
  }

  function getSteps() as Number? {
    return Toybox.ActivityMonitor.getInfo().steps;
  }

  function getStepsString() as String {
    var steps = getSteps();
    if (steps == null) {
      return "-";
    }
    return getSteps().format("%d");
  }

  function getFloors() as Number? {
    return Toybox.ActivityMonitor.getInfo().floorsClimbed;
  }

  function getFloorsString() as String {
    var floors = getFloors();
    if (floors == null) {
      return "-";
    }
    return getFloors().format("%d");
  }

  function getBattery() as Float {
    return Toybox.System.getSystemStats().battery;
  }

  function getBatteryString() as String {
    return getBattery().format("%d") + "%";
  }

function getStepGoal() as Number or Null {
    return Toybox.ActivityMonitor.getInfo().stepGoal;
}

function getStepsRatioThresholded() as Float or Null {
    var stepGoal = getStepGoal();
    var steps = getSteps();

    if (steps == null || stepGoal == null) {
        return null;
    }

    if (steps > stepGoal) {
        steps = stepGoal;
    }

    return 1.0 * steps / stepGoal;
}

}
