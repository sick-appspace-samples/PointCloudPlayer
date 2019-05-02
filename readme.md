## PointCloudPlayer
Read scanner record files from resources, view the point cloud and printing meta information to the console.  
### Description
This sample creates a PointCloudProvider which reads ".ssr"-files from the
file system. This Provider takes PointClouds with a period of 500ms, which are
provided asynchronously to the handleNewPointCloud function. The PointCloud is
shown in the PointCloud View and the timestamp from SensorData along with the
PointCloud properties are logged to the terminal. This is useful to play recorded
data for development purposes.  
When running this sample on the emulator, the point cloud is being displayed in
the PointCloud viewer on the web-page and the meta data is logged to the console

### Topics
Algorithm, Point-Cloud, Sample, SICK-AppSpace