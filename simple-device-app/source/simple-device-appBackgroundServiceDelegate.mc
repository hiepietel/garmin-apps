using Toybox.Background;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

(:background)
class SimpleDeviceAppBackgroundServiceDelegate extends Toybox.System.ServiceDelegate {

    function initialize() {
		Sys.ServiceDelegate.initialize();
		inBackground=true;				//trick for onExit()
	}
	
    function onTemporalEvent() {
    	var now=Sys.getClockTime();
    	var ts=now.hour+":"+now.min.format("%02d");
        Sys.println("bg exit: "+ts);
        //just return the timestamp

        // var alert = new SimpleDeviceAppAlert({
        //     :timeout => 2000,
        //     :font => Gfx.FONT_MEDIUM,
        //     :text => "onPreviousPage",
        //     :fgcolor => Gfx.COLOR_RED,
        //     :bgcolor => Gfx.COLOR_WHITE
        // });





        Background.exit(ts);
    }
}