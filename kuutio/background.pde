int CLOUD_COUNT = 50;
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
  double spawnTime;
  Cloud() {
    size = 0;
  }
  Cloud(int newSize, double newSpawnTime) {
    size = newSize; //<>//
    cloudParts = new int[newSize];
    xVibrations = new int[newSize];
    yVibrations = new int[newSize];
    zVibrations = new int[newSize];
    spawnTime = newSpawnTime;
    
    int xBase = (int)random(0, 1000);
    int zBase = (int)random(0, 2000);
    
    for (int i = 0; i < newSize; i++) {
      cloudParts[i] = int(random(80, 100));
      xVibrations[i] = xBase + int(random(0, 50));
      yVibrations[i] = height/2;//int(random(40, 50));
      zVibrations[i] = zBase + int(random(-50, 50));
    }
 }
 void createCloud() {
   float yAxisValue = (float)moonlander.getValue("tblocks_per_second") * (float)(moonlander.getCurrentTime() - spawnTime);
   for (int i = 0; i < size; i++) {
     pushMatrix();
     fill(255, 255, 255, 60); //<>//
     noStroke();
     int x = xVibrations[i] + (i * 40);
     float y = yAxisValue + 10 * sin((float)moonlander.getCurrentTime() + yVibrations[i]);
     int z = zVibrations[i];
     translate(x,  y, z);
     sphere(max(abs(cloudParts[i]*sin((float)moonlander.getCurrentTime() + cloudParts[i])), 10));
     popMatrix();
   }
 }
}

void drawBackground() {
    int newCloudSize = moonlander.getIntValue("new_cloud_size");
    if (newCloudSize != 0 && newCloudSize != previousValue) {
      clouds[cloudIndex] = new Cloud(newCloudSize, moonlander.getCurrentTime()); //<>//
      cloudIndex = (cloudIndex + 1) % CLOUD_COUNT;
    }
    previousValue = newCloudSize;
    for (int i = 0; i < CLOUD_COUNT; i++) {
      if (clouds[i] != null) {
        clouds[i].createCloud();
      }
  }
}