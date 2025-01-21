using Toybox.Background;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

(:background)
class PopeTimeServiceDelegate extends Toybox.System.ServiceDelegate {

    function initialize() {
		Sys.ServiceDelegate.initialize();
	}

    function onTemporalEvent(){
        Background.requestApplicationWake("It's time. A u ready to see him?");
        Background.exit(null);
    }
}