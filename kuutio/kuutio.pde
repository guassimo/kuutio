import moonlander.library.*;
import ddf.minim.*;

Moonlander moonlander;
PGraphics creditsLayer;

void setup() {
  moonlander = Moonlander.initWithSoundtrack(this, "Secret_of_Mana_Stomp_the_Summer_Sky_OC_ReMix.mp3", 127, 32);
  size(1340, 800, P3D);
  creditsLayer = createGraphics(width,height);
  moonlander.start();
}

void draw() {
  moonlander.update();
  
  // slighly modified default lights
  ambientLight(128, 128, 128);
  directionalLight(128, 128, 128, 1, 1, -1); // <- this is NOT default. location is different
  lightFalloff(1, 0, 0);
  lightSpecular(0, 0, 0);
  
  if (moonlander.getValue("credits_visible") == 0) {
    background(128, 128, 255);
    drawTower();
    drawBackground();
    
    if (moonlander.getValue("title_visible") > 0) {
      textSize(100);
      textAlign(CENTER);
      fill(255);
      //text("Moon time: " + String.format("%.2f", moonlander.getCurrentTime()), 10, 30);
      //text("Moon row: " + String.format("%.2f", moonlander.getCurrentRow()), 10, 60);
      text("Clouds & tower", width/2, height/2);
    }
  }
  else {
    background(0);
    textSize(50);
    textAlign(CENTER);
    fill(255);
    text("Programming: guassimo & onoki\n\nMusic: Stomp the Summer Sky by Ziwtra (OC Remix)", width/2, height/2);
  }
  
  if (moonlander.getValue("show_finished") > 0) {
    exit(); 
  }
}