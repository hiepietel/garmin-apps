using Toybox.Background;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;


(:background)
class PopeTimeServiceDelegate extends Toybox.System.ServiceDelegate {

    function initialize() 
    {
		Sys.ServiceDelegate.initialize();
	}

    function onTemporalEvent()
    {
        var creator = new PopeTimeBackgroundServiceCreator();
        creator.create();

        Background.requestApplicationWake("It is 21:37 o'clock. A u ready to see him?");
        Background.exit(null);
    }
}