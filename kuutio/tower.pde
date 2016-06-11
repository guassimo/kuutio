
final int TB_STATE_NONE = 0;
final int TB_STATE_FALLING = 1;
final int TB_STATE_BOUNCE = 2;
final int TB_STATE_STILL = 3;

final int TB_SPAWN_INTERVAL = 1000;
final int TB_COUNT = 100;
final int TB_PER_LAYER = 10;

class TowerBlock {
 float angle;
 float radius;
 float y;
 int state;
 
 TowerBlock() {
   angle = 0;
   radius = 0;
   y = 0;
   state = TB_STATE_NONE;
 }

 TowerBlock(float newAngle, float newRadius) {
   angle = newAngle;
   radius = newRadius;
   y = 100;
   state = TB_STATE_FALLING;
 }
}


TowerBlock[] tblocks = new TowerBlock[TB_COUNT];
int tblockIndexSpawnNext = 0;
double tblockLastSpawned = -1;

void drawTower() {
  
  /***********
   TOWER OF BRICKS
   ***********/
   
  // params
  //  - number of active blocks
  //  - radius distortion amount
  //  - radius distortion mode or something
  //  - global tower rotation
  
  // spawn a new block
  if (tblockLastSpawned < 0 || moonlander.getCurrentTime() - tblockLastSpawned > 1) {
    tblockLastSpawned = moonlander.getCurrentTime();
    tblocks[tblockIndexSpawnNext] = new TowerBlock(PI/TB_PER_LAYER * tblockIndexSpawnNext % TB_PER_LAYER, 200);
    tblockIndexSpawnNext = (tblockIndexSpawnNext + 1) % TB_COUNT;
  }
  
  // update all blocks states
  for (int i = 0; i < TB_COUNT; i++) {
    TowerBlock block = tblocks[i];
    if (block == null) continue;
    
    switch (block.state) {
      case TB_STATE_FALLING:
        //  - y
        //  - state (falling, bounce, still, none)
        //  - time ref
        break;
      case TB_STATE_BOUNCE:
      
        break;
      case TB_STATE_STILL:
      
        break;
      default:
        // nothing
    }
    
    // draw blocks
    if (block.state != TB_STATE_NONE) {
      pushMatrix();
      translate(width/2 + block.radius * sin(block.angle), 3*height/4, block.radius * cos(block.angle));
      rotateY(block.angle);
      stroke(255);
      noFill();
      box(50);
      popMatrix();
    }
  }
    
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
  //  - y
  // have array of m blocks
  // activate a block based on time (keep track on when last one was activated)
  // update all blocks states
  //  - y
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
  //camera(width/2.0, 0, 2 * (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  /*translate(width/2, height/2, -100);
  stroke(255);
  noFill();
  box(200);*/
}