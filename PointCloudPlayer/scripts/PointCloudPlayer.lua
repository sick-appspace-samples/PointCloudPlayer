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
handle:setPath(PLAY_PATH)
-- Set the a cycle time of 500ms
handle:setCycleTime(3000)

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
Script.register('Engine.OnStarted', handleOnStarted)

-- Definition of the callback function which is registered at the provider
-- PointCloud contains the image itself
-- Supplements contains supplementary information about the image
--@handleNewPointCloud(pointcloud:PointCloud, sensorData:SensorData)
local function handleNewPointCloud(pointcloud, sensorData)
  -- get the timestamp from the metadata
  local timeStamp = sensorData:getTimestamp()
  -- get the filename from the metadata
  local origin = sensorData:getOrigin()

  -- get the dimensions of the point cloud
  local points, width, height = PointCloud.getSize(pointcloud)
  print(
    "PointCloud '" .. origin .. "': ts=" .. timeStamp ..
    'ms, points=' .. points .. ', width=' .. width .. ', height=' .. height
  )

  -- present the current point cloud in the viewer
  viewer:addPointCloud(pointcloud)
  viewer:present()
end
-- Register the callback function
handle:register('OnNewPointCloud', handleNewPointCloud)

--End of Function and Event Scope------------------------------------------------
