int CLOUD_COUNT = 100;
Cloud[] clouds = new Cloud[CLOUD_COUNT];
int cloudIndex = 0;
int previousValue = 0;
class Cloud {
  int size;
  int[] cloudParts = null;
  int[] xVibrations = null;
  int[] yVibrations = null;
  int[] zVibrations = null;
  int[] cloudPositions = new int[2];
  Cloud() {
    size = 0;
  }
  void generateCloudPosition() {
      cloudPositions[0] = int(random(800,1800));
      cloudPositions[1] = int(random(800,1800));
  }  
  Cloud(int newSize) {
    size = newSize; //<>//
    generateCloudPosition();
    cloudParts = new int[newSize];
    xVibrations = new int[newSize];
    yVibrations = new int[newSize];
    zVibrations = new int[newSize];
    
    int xBase = (int)random(0, 1000);
    int zBase = (int)random(0, 2000);
    
    for (int i = 0; i < newSize; i++) {
//int i = 0;
      cloudParts[i] = int(random(80, 100));
      xVibrations[i] = xBase + int(random(0, 50));
      yVibrations[i] = height/2;//int(random(40, 50));
      zVibrations[i] = zBase + int(random(-50, 50));
    }
 }
 void createCloud() {
   float yAxisValue = 25 * (float)(moonlander.getCurrentTime());
   for (int i = 0; i < size; i++) {
     //int i = 0;
     pushMatrix();
     fill(190,190,190,60);
     //fill(190, 190, 190, 1); //<>//
     noStroke();
     //lights();
     int x = xVibrations[i] + (i * 40);
     float y = yAxisValue + 10 * sin((float)moonlander.getCurrentTime() + yVibrations[i]);
     int z = zVibrations[i];
     translate(x,  y, z);
     print("sphereX = " + x + "\n");
     //print("sphereY = " + y + "\n");
     //print("sphereZ = "+ z + "\n");
     sphere(max(abs(cloudParts[i]*sin((float)moonlander.getCurrentTime() + cloudParts[i])), 10));
     //print("shadeSize = " + max(abs(cloudParts[i]*sin((float)moonlander.getCurrentTime() + cloudParts[i])), 10) + "\n");
     popMatrix();
   }
 }
}

void drawBackground() {
    background(128, 128, 255);
    int newCloudSize = moonlander.getIntValue("new_cloud_size");
    if (newCloudSize != 0 && newCloudSize != previousValue) {
      clouds[cloudIndex] = new Cloud(newCloudSize); //<>//
      cloudIndex = (cloudIndex + 1) % CLOUD_COUNT;
    }
    previousValue = newCloudSize;
    for (int i = 0; i < CLOUD_COUNT; i++) {
      //int i = 0;
      if (clouds[i] != null) {
        clouds[i].createCloud();
      }
  }
}