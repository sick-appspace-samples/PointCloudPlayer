--[[----------------------------------------------------------------------------

  Application Name: PointCloudPlayer

  Description:
  Read scanner record files from resources, view the point cloud and printing meta
  information to the console.

  This sample creates a PointCloudProvider which reads ".ssr"-files from the
  filesystem. This Provider takes PointClouds with a period of 500ms, which are
  provided asynchronously to the handleNewPointCloud function. The PointCloud is
  shown in the PointCloud View and the timestamp from SensorData along with the
  PointCloud properties are logged to the terminal. This is useful to play recorded
  data for development purposes.

  When running this sample on the emulator, the point cloud is being displayed in
  the PointCloud viewer on the webpage and the meta data is logged to the console.

------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

local PLAY_PATH = 'resources/'

-- Create an PointCloudProvider
local handle = PointCloud.Provider.Directory.create()
-- Define the path from which the driver gets images
PointCloud.Provider.Directory.setPath(handle, PLAY_PATH)
-- Set the a cycle time of 500ms
PointCloud.Provider.Directory.setCycleTime(handle, 3000)
-- Register the callback function

-- create a viewer instance
local viewer = View.create()
viewer:setID('viewer3D')

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function handleOnStarted()
  -- start the provider
  local success = PointCloud.Provider.Directory.start(handle)
  if success then
    print('PointCloudPlayer successfully started.')
  else
    print('PointCloudPlayer could not be started.')
  end
end
Script.register("Engine.OnStarted", handleOnStarted)

-- Definition of the callback function which is registered at the provider
-- PointCloud contains the image itself
-- Supplements contains supplementary information about the image
local function handleNewPointCloud(pointcloud, sensorData)
  -- get the timestamp from the metadata
  local timeStamp = SensorData.getTimestamp(sensorData)
  -- get the filename from the metadata
  local origin = SensorData.getOrigin(sensorData)

  -- get the dimensions of the point cloud
  local points, width, height = PointCloud.getSize(pointcloud)
  print(
    "PointCloud '" .. origin .. "': ts=" .. timeStamp ..
    'ms, points=' .. points .. ', width=' .. width .. ', height=' .. height
  )

  -- present the current point cloud in the viewer
  View.view(viewer, pointcloud)
end
PointCloud.Provider.Directory.register(handle, 'OnNewPointCloud', handleNewPointCloud)

--End of Function and Event Scope------------------------------------------------
