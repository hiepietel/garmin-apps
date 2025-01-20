using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;
using Toybox.System as Sys;

class PopeTimeNotificationView extends Ui.View
{
    hidden var invertedBitmp = false;
    hidden var timeout;
    hidden var bitmap;
    hidden var bitmapRezId;
    hidden var thuglifeBitmap;
    
    hidden var timer; 
    hidden var framerateTimer;
    hidden var bitmapTimeout;
    hidden var popeAnimationStep = 0;

    function initialize() {
        View.initialize();
    
        timeout = 6 * 1000;
        bitmapTimeout = 0.25 * 1000;

        timer = new Timer.Timer();
        framerateTimer = new Timer.Timer();
    }

    function onLayout(dc) as Void {

        CreateBitmap(Rez.Drawables.YellowPope);
        
        thuglifeBitmap = new Ui.Bitmap({
            :rezId => Rez.Drawables.Thuglife
        });

            var thuglifeBitmapDimmensions = thuglifeBitmap.getDimensions();
            if(thuglifeBitmapDimmensions[0] != null && thuglifeBitmapDimmensions[1] != null){          
                var systemSettins = System.getDeviceSettings();

                var screenWidth = systemSettins.screenWidth;
                var screenHeight = systemSettins.screenHeight;
                
                var bitmapWidth = thuglifeBitmapDimmensions[0];
                var bitmapHeight = thuglifeBitmapDimmensions[1];

                thuglifeBitmap.locX = screenWidth / 2 - bitmapWidth / 2;
                //thuglifeBitmap.locY = screenHeight / 2  - bitmapHeight / 2 + 35;
                thuglifeBitmap.locY = - bitmapHeight;

                
            }

        //Sys.println("Alert: on Layout");
    }

    function onShow() {
        
        timer.start(method(:dismiss), timeout, false);

        framerateTimer.start(method(:requestUpdate), bitmapTimeout, true);
        // if (Attention has :vibrate) {
        //     Attention.vibrate(vibeData);
        // }
    }

    function onHide() {
        bitmap = null;
        timer.stop();
        framerateTimer.stop();
    }

    function onUpdate(dc) {

        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK); 
        dc.clear(); 

        if(popeAnimationStep == 0){
            if (invertedBitmp == true){
                UpdateBitmap(Rez.Drawables.YellowPopeInverted);
            }
            else{
                UpdateBitmap(Rez.Drawables.YellowPope);
            }

            invertedBitmp = invertedBitmp == false;

            bitmap.draw(dc);
        }
        else{
            CreateBitmap(Rez.Drawables.YellowPope);

            var offset = 5;

             var thuglifeBitmapDimmensions = thuglifeBitmap.getDimensions();
            if(thuglifeBitmapDimmensions[1] != null){
                var bitmapHeight = thuglifeBitmapDimmensions[1];
                thuglifeBitmap.locY += 10;
                
                var systemSettins = System.getDeviceSettings();

                var desiredHeight = systemSettins.screenHeight / 2  - bitmapHeight / 2 + 30;

                if(thuglifeBitmap.locY < (desiredHeight - offset))
                {
                   thuglifeBitmap.locY += offset; 
                }
                else
                {
                    thuglifeBitmap.locY = desiredHeight;
                }

            }




            thuglifeBitmap.locY += 10;

            bitmap.draw(dc);
            thuglifeBitmap.draw(dc);
        }


    }

    function dismiss() {
        if(popeAnimationStep == 0){
            timer.start(method(:dismiss), timeout, false);
            popeAnimationStep ++;
        }
        else if(popeAnimationStep == 1){
            timer.start(method(:dismiss), timeout, false);
            popeAnimationStep ++;
        }
        else
        {
            bitmap = null;
            Ui.popView(SLIDE_IMMEDIATE);
        }

    }

    protected function requestUpdate(){
        Ui.requestUpdate();
    }

    private function UpdateBitmap(rezId){
        if(bitmap != null && bitmapRezId != rezId){
            bitmap = null;
            CreateBitmap(rezId);
        }

    }

    private function CreateBitmap(rezId){
        if(bitmap == null){ 
            bitmap = new Ui.Bitmap({
                :rezId => rezId,
                :identifier => 1,
                :locX=> -100,
                :locY => -100,
                :width => 240,
                :height => 240
            });

            bitmapRezId = rezId;

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