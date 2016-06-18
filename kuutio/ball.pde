final int B_STATE_NONE = 0;
final int B_STATE_BOUNCE = 1;
final int B_STATE_STILL = 2;
final int B_SPAWN_INTERVAL = 1000;
final int B_PER_LAYER = 25;
final int B_TARGET_HEIGHT = 600;
final int B_CENTER_Z = 1000;
final int B_LAYER_HEIGHT = 25;

class Ball {
 float angle;
 float radius;
 float y;
 int state;
 double refTime;
 Ball(float newAngle, float newRadius, double newRefTime) {
   angle = newAngle;
   radius = newRadius;
   y = -100;
   state = B_STATE_BOUNCE;
   refTime = newRefTime;
 }
}

int ballstep = 0;
float balltotalAngleOffset = 0;
double ballLastUdated = -1;
boolean firstTime = true;
float currentRadius = 0;
Ball ball = null;
void drawBall() {
    if (moonlander.getValue("spawn_ball") == 0) return;
    if (moonlander.getValue("spawn_ball") > 0 && firstTime) {
      firstTime = false;
      ballLastUdated = moonlander.getCurrentTime();
      balltotalAngleOffset += TWO_PI/B_PER_LAYER * 0.02;
      currentRadius = 320 + (float)moonlander.getValue("tblocks_radius_distortion_amplitude") * sin((float)moonlander.getValue("tblocks_radius_distortion_frequency") * (float)moonlander.getCurrentTime());
      ball = new Ball(TWO_PI/B_PER_LAYER * (ballstep % B_PER_LAYER) + balltotalAngleOffset, currentRadius, ballLastUdated);
      ballstep = (ballstep + 1) % B_LAYER_HEIGHT;
    } else if ((moonlander.getCurrentTime() - ballLastUdated) > 50 / moonlander.getValue("tblocks_per_second")) {
        ballLastUdated = moonlander.getCurrentTime();
        currentRadius = 320 + (float)moonlander.getValue("tblocks_radius_distortion_amplitude") * sin((float)moonlander.getValue("tblocks_radius_distortion_frequency") * (float)moonlander.getCurrentTime());
        balltotalAngleOffset += TWO_PI/B_PER_LAYER * 0.02;
        ball.angle = TWO_PI/B_PER_LAYER * (ballstep % B_PER_LAYER) + balltotalAngleOffset;
        ball.radius = currentRadius;
        ball.refTime = ballLastUdated;
        ball.state = B_STATE_BOUNCE;
        ballstep = (ballstep + 1) % B_LAYER_HEIGHT;
    }
  
    if (ball == null) return;
    
        switch (ball.state) {
      case B_STATE_BOUNCE:
        ball.y = B_TARGET_HEIGHT -100 + 10000 * (float)Math.pow((moonlander.getCurrentTime() - ball.refTime - 0.1), 2);
        if (ball.y > B_TARGET_HEIGHT) {
          ball.y = B_TARGET_HEIGHT;
          ball.state = B_STATE_STILL;
          ball.refTime = moonlander.getCurrentTime();
        }
        break;
      case B_STATE_STILL:
        ball.y = B_TARGET_HEIGHT - 30 + (float)moonlander.getValue("tblocks_fall_speed") * (float)(moonlander.getCurrentTime() - ball.refTime);
        break;
        }
  
      if (ball.state != B_STATE_NONE) {
        pushMatrix();
        translate(width/2 + ball.radius * sin(ball.angle), ball.y, B_CENTER_Z + ball.radius * cos(ball.angle));
        //rotateY(ball.angle);
        noStroke();
        fill(255, 0, 0);
        sphere(50);
        popMatrix();
    }
}