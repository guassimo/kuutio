void drawTower() {
 // onoki's code here
 
  int cameraAngleX = moonlander.getIntValue("camera_angle_x");
  int cameraAngleY = moonlander.getIntValue("camera_angle_y");
  camera(cameraAngleX, cameraAngleY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  translate(width/2, height/2, -100);
  stroke(255);
  noFill();
  box(200);
}