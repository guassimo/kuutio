int CLOUD_COUNT = 10;
Cloud[] clouds = new Cloud[CLOUD_COUNT];
int cloudIndex = 0;

class Cloud {
  int size;
  int[] cloudParts = null;
  int[] yPositions = null;
  int[] xPositions = null;
  int[] zPositions = null;
  Cloud() {
    size = 0;
  }
  Cloud(int newSize) {
    size = newSize; //<>//
    cloudParts = new int[newSize];
    xPositions = new int[newSize];
    yPositions = new int[newSize];
    zPositions = new int[newSize];
    for (int i = 0; i < newSize; i++) {
      cloudParts[i] = int(random(50, 100));
      xPositions[i] = int(random(50));
      yPositions[i] = int(random(100));
      zPositions[i] = int(random(100));
    }
 }
 void createCloud() {
   for (int i = 0; i < size; i++) {
     pushMatrix();
     fill(190190190); //<>//
     noStroke();
     lights();
     translate(width/4 + (i * xPositions[i]),  height/2 + yPositions[i], zPositions[i]);
     sphere(cloudParts[i]);
     popMatrix();
   }
 }
}

void drawBackground() {
    int newCloudSize = moonlander.getIntValue("new_cloud_size");
    if (newCloudSize > 0) {
      clouds[cloudIndex] = new Cloud(newCloudSize); //<>//
      //cloudIndex = (cloudIndex +1) % CLOUD_COUNT;
    }
    for (int i = 0; i < CLOUD_COUNT; i++) {
      if (clouds[i] != null) {
        clouds[i].createCloud();
      }
  }
}