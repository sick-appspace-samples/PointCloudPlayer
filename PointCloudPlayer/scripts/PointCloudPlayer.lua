
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

---Definition of the callback function which is registered at the provider
---@param pointcloud PointCloud contains the image itself
---@param sensorData SensorData contains supplementary information about the image

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
