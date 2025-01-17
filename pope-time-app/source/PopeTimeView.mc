import Toybox.Graphics;
using Toybox.WatchUi as Ui;

class PopeTimeView extends Ui.View {

    hidden var bitmap = null;

    function initialize() {
        View.initialize();
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
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        bitmap.draw(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        bitmap = null;
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