void drawTower() {
  
  /***********
   TOWER OF BRICKS
   ***********/
   
  // params
  //  - number of active blocks
  //  - radius distortion amount
  //  - radius distortion mode or something
  //  - global tower rotation
  
  // define 3d block
  //  - angle on circle
  //  - radius
  //  - spacing on outer radius
  //  - state
  //  - z
  // have array of n blocks
  // activate a block based on time (keep track on when last one was activated)
  // update all blocks states
  //  - z
  //  - state (falling, bounce, still, none)
  //  - time ref
  // draw blocks
  
  
  /***********
   STAIRCASE
   ***********/
  
  // params
  //  - speed of activation
  //  - distortion amount
  //  - (radius distortion amount)
  //  - (radius distortion mode or something)
  //  - (global tower rotation)
  
  // define 3d staircase block
  //  - angle on circle
  //  - radius
  //  - state
  //  - z
  // have array of m blocks
  // activate a block based on time (keep track on when last one was activated)
  // update all blocks states
  //  - z
  //  - state (raising, arriving, still, none)
  //  - time ref
  // draw blocks
   
  
  /***********
   CAMERA CONTROL
   ***********/
   
  // params
  //  - camera distance
  //  - camera horizontal distortion frequency
  //  - camera horizontal distortion amplitude
  
  /*
  int cameraAngleX = moonlander.getIntValue("camera_angle_x");
  int cameraAngleY = moonlander.getIntValue("camera_angle_y");*/
  camera(width/2.0, 0, 2 * (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  translate(width/2, height/2, -100);
  stroke(255);
  noFill();
  box(200);
}