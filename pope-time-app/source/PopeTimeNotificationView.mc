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

    function initialize() {
        View.initialize();
    
        timeout = 20 * 1000;
        bitmapTimeout = 1 * 1000;

        timer = new Timer.Timer();
        bitmapTimer = new Timer.Timer();
    }

    function onLayout(dc) as Void {

        CreateBitmap();

        //Sys.println("Alert: on Layout");
    }

    function onShow() {
        
        timer.start(method(:dismiss), timeout, false);

        bitmapTimer.start(method(:requestUpdate), bitmapTimeout, true);
        // if (Attention has :vibrate) {
        //     Attention.vibrate(vibeData);
        // }
    }

    function onHide() {
        bitmap = null;
        timer.stop();
        bitmapTimer.stop();
    }

    function onUpdate(dc) {

        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK); 
        dc.clear(); 

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

    function dismiss() {
        bitmap = null;
        Ui.popView(SLIDE_IMMEDIATE);
    }

    private function requestUpdate(){
        Ui.requestUpdate();
    }

    private function CreateBitmap(){
        if(bitmap == null){
            bitmap = new Ui.Bitmap({
                :rezId => Rez.Drawables.YellowPope,
                :locX=> -100,
                :locY => -100
            });

            var bitmapDimmensions = bitmap.getDimensions();
            if(bitmapDimmensions[0] != null && bitmapDimmensions[1] != null){          
                var systemSettins = System.getDeviceSettings();

                var screenWidth = systemSettins.screenWidth;
                var screenHeight = systemSettins.screenHeight;
                
                var bitmapWidth = bitmapDimmensions[0];
                var bitmapHeight = bitmapDimmensions[1];

                bitmap.locX = screenWidth / 2 - bitmapWidth / 2;
                bitmap.locY = screenHeight / 2 - bitmapHeight / 2;
            }
        }
    }  
}