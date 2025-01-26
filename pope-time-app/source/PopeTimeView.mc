import Toybox.Graphics;
using Toybox.WatchUi as Ui;

class PopeTimeView extends Ui.View {

    hidden var bitmap = null;
    hidden var hintColorCounter = 0;
    hidden var timer; 

    function initialize() {
        View.initialize();

        timer = new Timer.Timer();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        CreateBitmap();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        CreateBitmap();

        timer.start(method(:requestUpdate), 700, true);
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        bitmap.draw(dc);
        var dcWidth = dc.getWidth();
        var dcHeight = dc.getHeight();

        var arcLength = 30;
        var arcWidth = 4;
        var arcOffset = 25;
        dc.setPenWidth(arcWidth);

        if(hintColorCounter % 2 == 0){
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        }
        else{
            dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
        }

        //dc.setColor(Graphics.COLOR_DK_RED, Graphics.COLOR_TRANSPARENT);
        dc.drawArc(dcWidth / 2, dcHeight / 2, dcHeight / 2 - arcWidth / 2,
                Graphics.ARC_CLOCKWISE, 0 + arcLength / 2 + arcOffset,
                0 - arcLength / 2 + arcOffset);

        hintColorCounter++;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        bitmap = null;
    }

    protected function requestUpdate()
    {   
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