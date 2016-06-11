import moonlander.library.*;
import ddf.minim.*;

/* TODO

*/


Moonlander moonlander;

void setup() {
    moonlander = Moonlander.initWithSoundtrack(this, "Chrono_Trigger_Spekkio_Beach_Party_OC_ReMix.mp3", 127, 8);
    size(400, 400, P3D);
    moonlander.start();
}

void draw() {
    moonlander.update();
    
    drawBackground();
    drawTower();
    
    // credits
    textSize(24);
    text("Time: " + String.format("%.2f", moonlander.getCurrentTime()), 10, 30);
    text("Row: " + String.format("%.2f", moonlander.getCurrentRow()), 10, 60);
    text("Programming: guassimo & onoki", 10, 90);
    text("Music: Spekkio's Beach Party by djpretzel", 10, 90);
}