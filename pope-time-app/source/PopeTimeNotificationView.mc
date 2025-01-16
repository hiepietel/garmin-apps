using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;
using Toybox.System as Sys;

class PopeTimeNotificationView extends Ui.View
{
    hidden var invertedBitmp = false;
    hidden var timeout;
    hidden var bitmap;
    hidden var timer; 
    hidden var bitmapTimer;
    hidden var bitmapTimeout;

    var screenWidth = System.getDeviceSettings().screenWidth;
    var screenHeight = System.getDeviceSettings().screenHeight;

    function initialize() {
        View.initialize();
    
        timeout = 20 * 1000;
        bitmapTimeout = 1 * 1000;

        timer = new Timer.Timer();
        bitmapTimer = new Timer.Timer();
    }

    function onLayout(dc) as Void {
        //setLayout(Rez.Layouts.Notification(dc));

        bitmap = new Ui.Bitmap({
            :rezId => Rez.Drawables.YellowPopeInverted,
            :locX=> -100,
            :locY => -100
        });

        Sys.println("Alert: on Layout");
    }

    function onShow() {
        timer.start(method(:dismiss), timeout, false);

        var bitmapWidth = bitmap.getDimensions()[0];
        var bitmapHeight = bitmap.getDimensions()[1];

        bitmap.locX = screenWidth / 2 - bitmapWidth / 2;
        bitmap.locY = screenHeight / 2 - bitmapHeight / 2;

        bitmapTimer.start(method(:requestUpdate), bitmapTimeout, true);
        // if (Attention has :vibrate) {
        //     Attention.vibrate(vibeData);
        // }
    }

    function onHide() {
        timer.stop();
        bitmapTimer.stop();
    }

    function onUpdate(dc) {

        invertedBitmp = invertedBitmp == false;

        Sys.println(invertedBitmp);

        if (invertedBitmp == true){
            bitmap.setBitmap(Rez.Drawables.YellowPopeInverted);
        }
        else{
            bitmap.setBitmap(Rez.Drawables.YellowPope);
        }

        bitmap.draw(dc);

    }

    function requestUpdate(){
        Ui.requestUpdate();
    }

    function dismiss() {
        Ui.popView(SLIDE_IMMEDIATE);
    }
}