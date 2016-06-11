
final int TB_STATE_NONE = 0;
final int TB_STATE_FALLING = 1;
final int TB_STATE_BOUNCE = 2;
final int TB_STATE_STILL = 3;
final int TB_SPAWN_INTERVAL = 1000;
final int TB_COUNT = 1000;
final int TB_PER_LAYER = 25;
final int TB_TARGET_HEIGHT = 600;
final int TB_TOWER_CENTER_Z = 1000;
final int TB_LAYER_HEIGHT = 25;

class TowerBlock {
 float angle;
 float angleDistort;
 float radius;
 float hue;
 float y;
 int state;
 double refTime;

 TowerBlock(float newAngle, float newAngleDistort, float newRadius, double newRefTime, float newHue) {
   angle = newAngle;
   angleDistort = newAngleDistort;
   radius = newRadius;
   hue = newHue;
   y = -100;
   state = TB_STATE_FALLING;
   refTime = newRefTime;
 }
}


TowerBlock[] tblocks = new TowerBlock[TB_COUNT];
int tblockIndexSpawnNext = 0;
double tblockLastSpawned = -1;
float totalAngleOffset = 0;

void drawTower() {
  if (moonlander.getValue("tblocks_per_second") <= 0) return;
  
  /***********
   TOWER OF BRICKS
   ***********/
   
  // params
  //  - global tower rotation (todo)
  
  // spawn a new block
  if (tblockLastSpawned < 0 || (moonlander.getCurrentTime() - tblockLastSpawned) > 1 / moonlander.getValue("tblocks_per_second")) {
    tblockLastSpawned = moonlander.getCurrentTime();
    totalAngleOffset += TWO_PI/TB_PER_LAYER * 0.02;
    float newRadius = 200 + (float)moonlander.getValue("tblocks_radius_distortion_amplitude") * sin((float)moonlander.getValue("tblocks_radius_distortion_frequency") * (float)moonlander.getCurrentTime());
    tblocks[tblockIndexSpawnNext] = new TowerBlock(TWO_PI/TB_PER_LAYER * (tblockIndexSpawnNext % TB_PER_LAYER) + totalAngleOffset, (float)random(-TWO_PI/TB_PER_LAYER/2, TWO_PI/TB_PER_LAYER/2), newRadius, tblockLastSpawned, random(195,220));
    tblockIndexSpawnNext = (tblockIndexSpawnNext + 1) % TB_COUNT;
  }
  
  // update all blocks states
  for (int i = 0; i < TB_COUNT; i++) {
    TowerBlock block = tblocks[i];
    if (block == null) continue;
    
    switch (block.state) {
      case TB_STATE_FALLING:
        block.y = 1000 * (float)(moonlander.getCurrentTime() - block.refTime);
        if (block.y > TB_TARGET_HEIGHT) {
          block.y = TB_TARGET_HEIGHT;
          block.state = TB_STATE_BOUNCE;
          block.refTime = moonlander.getCurrentTime();
        }
        break;
      case TB_STATE_BOUNCE:
        block.y = TB_TARGET_HEIGHT -100 + 10000 * (float)Math.pow((moonlander.getCurrentTime() - block.refTime - 0.1), 2);
        if (block.y > TB_TARGET_HEIGHT) {
          block.y = TB_TARGET_HEIGHT;
          block.state = TB_STATE_STILL;
          block.refTime = moonlander.getCurrentTime();
        }
        break;
      case TB_STATE_STILL:
        block.y = TB_TARGET_HEIGHT + (float)moonlander.getValue("tblocks_fall_speed") * (float)(moonlander.getCurrentTime() - block.refTime);
        break;
      default:
        // nothing
    }
    
    // draw blocks
    if (block.state != TB_STATE_NONE) {
      pushMatrix();
      translate(width/2 + block.radius * sin(block.angle), block.y, TB_TOWER_CENTER_Z + block.radius * cos(block.angle));
      rotateY(block.angle + block.angleDistort);
      stroke(76, 40, 26);
      fill(block.hue, 105, 68);
      box(50, TB_LAYER_HEIGHT, 25);
      popMatrix();
    }
  }
    
  /***********
   STAIRCASE (todo)
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
  
  camera( width/2.0 + (float)moonlander.getValue("camera_radius") * sin((float)moonlander.getValue("camera_angle")), height/2.0 + (float)moonlander.getValue("camera_shake_amplitude")*sin((float)moonlander.getCurrentTime() * 50), TB_TOWER_CENTER_Z + (float)moonlander.getValue("camera_radius") * cos((float)moonlander.getValue("camera_angle")), 
          width/2.0, height/2.0, TB_TOWER_CENTER_Z, 
          0, 1, 0);
  //camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0) + 500, width/2.0, height/2.0, 0, 0, 1, 0);
}