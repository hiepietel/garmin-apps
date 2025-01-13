using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;
using Toybox.System as Sys;

class Delegate extends Ui.InputDelegate
{
    hidden var view;

    function initialize(view) {
    InputDelegate.initialize();
    self.view = view;
    }

    function onKey(evt) {
    view.dismiss();
    return true;
    }

    function onTap(evt) {
    view.dismiss();
    return true;
    }
}

class SimpleDeviceAppAlert extends Ui.View
{
    hidden var timer;
    hidden var timeout;
    hidden var text;
    hidden var font;
    hidden var fgcolor;
    hidden var bgcolor;

    function initialize() {
        View.initialize();

        text = "Alert";
        font = Gfx.FONT_MEDIUM;
        fgcolor = Gfx.COLOR_BLACK;
        bgcolor = Gfx.COLOR_WHITE;
        timeout = 15000;

        timer = new Timer.Timer();
    }

    function onLayout(dc) as Void {
        setLayout(Rez.Layouts.Alert(dc));
    }


    function onShow() {
        timer.start(method(:dismiss), timeout, false);
    }

    function onHide() {
        timer.stop();
    }

    function onUpdate(dc) {

        View.onUpdate(dc);
        // var tWidth = dc.getTextWidthInPixels(text, font);
        // var tHeight = dc.getFontHeight(font);

        // var bWidth = tWidth + 14;
        // var bHeight = tHeight + 14;

        // var bX = (dc.getWidth() - bWidth) / 2;
        // var bY = (dc.getHeight() - bHeight) / 2;

        // dc.setColor(bgcolor, bgcolor);
        // dc.fillRectangle(bX, bY, bWidth, bHeight);

        // dc.setColor(fgcolor, bgcolor);
        // for (var i = 0; i < 3; ++i) {
        // bX += i;
        // bY += i;
        // bWidth -= (2 * i);
        // bHeight -= (2 * i);

        // dc.drawRectangle(bX, bY, bWidth, bHeight);
    }

    // var tX = dc.getWidth() / 2;
    // var tY = bY + bHeight / 2;

    // dc.setColor(fgcolor, bgcolor);
    // dc.drawText(tX, tY, font, text, Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
    //}

    function dismiss() {
        Ui.popView(SLIDE_IMMEDIATE);
    }

    function pushView(transition) {
        Ui.pushView(self, new Delegate(self), transition);
    }
}