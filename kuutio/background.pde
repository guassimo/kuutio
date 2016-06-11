void drawBackground() {
  double bg_red = moonlander.getValue("background_red");
  int bg_green = moonlander.getIntValue("background_green");
  int bg_blue = moonlander.getIntValue("background_blue");
  background((int)bg_red, bg_blue, bg_green);
  // guassimo's code here
  noStroke();
  fill(255);
  ellipse(width/8, 75, 50*2, 50*2);
}