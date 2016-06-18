final int SB_STATE_NONE = 0;
final int SB_STATE_FLYING = 1;
final int SB_STATE_STILL = 2;
final int SB_SPAWN_INTERVAL = 1000;
final int SB_COUNT = 100;
final int SB_PER_LAYER = 25;
final int SB_TARGET_HEIGHT = 600;
final int SB_TARGET_RADIUS = 320;
final int SB_STAIRS_CENTER_Z = 1000;
final int SB_LAYER_HEIGHT = 40;

class StairBlock {
 float angle;
 float angleDistort;
 float radius;
 float hue;
 float y;
 int state;
 double refTime;
 StairBlock(float newAngle, float newAngleDistort, float newRadius, double newRefTime, float newHue) {
   angle = newAngle;
   angleDistort = newAngleDistort;
   radius = newRadius;
   hue = newHue;
   y = -100;
   state = SB_STATE_FLYING;
   refTime = newRefTime;
 }
}
StairBlock[] sblocks = new StairBlock[SB_COUNT];
int sblockIndexSpawnNext = 0;
double sblockLastSpawned = -1;
float sblocktotalAngleOffset = 0;

void drawStairs() {
  if (moonlander.getValue("tblocks_per_second") <= 0) return;
  
  if (sblockLastSpawned < 0 || (moonlander.getCurrentTime() - sblockLastSpawned) > 50 / moonlander.getValue("tblocks_per_second")) {
    sblockLastSpawned = moonlander.getCurrentTime();
    sblocktotalAngleOffset += TWO_PI/SB_PER_LAYER * 0.02;
    float newRadius = (float)moonlander.getValue("tblocks_radius_distortion_amplitude") * sin((float)moonlander.getValue("tblocks_radius_distortion_frequency") * (float)moonlander.getCurrentTime());
    sblocks[sblockIndexSpawnNext] = new StairBlock(TWO_PI/SB_PER_LAYER * (sblockIndexSpawnNext % SB_PER_LAYER) + sblocktotalAngleOffset, (float)random(-TWO_PI/SB_PER_LAYER/2, TWO_PI/SB_PER_LAYER/2), newRadius, sblockLastSpawned, random(94,207));
    sblockIndexSpawnNext = (sblockIndexSpawnNext + 1) % SB_COUNT;
  }
    // update all blocks states
  for (int i = 0; i < SB_COUNT; i++) {
    StairBlock block = sblocks[i];
    if (block == null) continue;
    
    switch (block.state) {
      case SB_STATE_FLYING:
        block.y = SB_TARGET_HEIGHT + (float)moonlander.getValue("tblocks_fall_speed") * (float)(moonlander.getCurrentTime() - block.refTime);
        block.radius = 1000 * (1-(float)(moonlander.getCurrentTime() - block.refTime));
        if (block.radius < SB_TARGET_RADIUS) {
          block.radius = SB_TARGET_RADIUS;
          block.state = SB_STATE_STILL;
          block.refTime = moonlander.getCurrentTime();
        }
        break;
      case SB_STATE_STILL:
        block.y = SB_TARGET_HEIGHT + (float)moonlander.getValue("tblocks_fall_speed") * (float)(moonlander.getCurrentTime() - block.refTime);
        break;
      default:
        // nothing
    }
        // draw blocks
    if (block.state != SB_STATE_NONE) {
      pushMatrix();
      translate(width/2 + block.radius * sin(block.angle), block.y, SB_STAIRS_CENTER_Z + block.radius * cos(block.angle));
      rotateY(block.angle + block.angleDistort);
      stroke(76, 40, 26);
      fill(block.hue, block.hue, block.hue);
      box(60, TB_LAYER_HEIGHT, 250);
      popMatrix();
    }
  }
}