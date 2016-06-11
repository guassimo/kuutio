import moonlander.library.*;
import ddf.minim.*;

/* TODO

*/


Moonlander moonlander;
PGraphics creditsLayer;

void setup() {
    moonlander = Moonlander.initWithSoundtrack(this, "Chrono_Trigger_Spekkio_Beach_Party_OC_ReMix.mp3", 127, 32);
    size(1340, 800, P3D);
    creditsLayer = createGraphics(width,height);
    moonlander.start();
}

void draw() {
    moonlander.update();
    
    drawBackground();
    drawTower();
    
    // credits
    creditsLayer.beginDraw();
    creditsLayer.background(000);
    creditsLayer.textSize(24);
    creditsLayer.text("Time: " + String.format("%.2f", moonlander.getCurrentTime()), 10, 30);
    creditsLayer.text("Row: " + String.format("%.2f", moonlander.getCurrentRow()), 10, 60);
    creditsLayer.text("Programming: guassimo & onoki", 10, 90);
    creditsLayer.text("Music: Spekkio's Beach Party by djpretzel", 10, 120);
    creditsLayer.endDraw();
    image(creditsLayer, 0, 0);
}