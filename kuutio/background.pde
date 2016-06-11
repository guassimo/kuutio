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
//int i = 0;
      cloudParts[i] = int(random(80, 100));
      xPositions[i] = int(random(50));
      yPositions[i] = int(random(10));
      zPositions[i] = int(random(100));
    }
 }
 void createCloud() {
   float yAxisValue = (moonlander.getIntValue("tblocks_per_second") * TB_PER_LAYER / moonlander.getIntValue("tblocks_per_second")) * (float)(moonlander.getCurrentTime());
   for (int i = 0; i < size; i++) {
     //int i = 0;
     pushMatrix();
     fill(190,190,190,60);
     //fill(190, 190, 190, 1); //<>//
     noStroke();
     //lights();
     translate(width/2 + (i * xPositions[i]),  -300 + yAxisValue + 10 * sin((float)moonlander.getCurrentTime() + yPositions[i]), zPositions[i]);
     sphere(max(cloudParts[i]*sin((float)moonlander.getCurrentTime() + cloudParts[i]), 10));
     popMatrix();
   }
 }
}

void drawBackground() {
    background(128, 128, 255);
    int newCloudSize = moonlander.getIntValue("new_cloud_size");
    if (newCloudSize > 0) {
      clouds[cloudIndex] = new Cloud(newCloudSize); //<>//
      //cloudIndex = (cloudIndex +1) % CLOUD_COUNT;
    }
    for (int i = 0; i < CLOUD_COUNT; i++) {
      //int i = 0;
      if (clouds[i] != null) {
        clouds[i].createCloud();
      }
  }
}