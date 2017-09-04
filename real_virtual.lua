local request = require "http.request"
local json = require "json"
local token = require "authorization_token"

local url = "https://www.strava.com/api/v3/athlete/activities?after=%d&per_page=%d"
local after = os.time({year=os.date("*t").year,month=1,day=1,hour=0,min=0,sec=0})
url = string.format(url, after, 200)

local req = request.new_from_uri(url)
req.headers:append("authorization", token)

local headers, stream = req:go()
if not headers then
  print("could not get the activities")
  os.exit(1)
end

local body, err = stream:get_body_as_string()
if not body and err then
  print(err)
  os.exit(2)
end

local activities, err = json.decode(body)
if not activities then
  print(err)
  os.exit(3)
end

local real_km, virtual_km = 0, 0

for i=1,#activities do
  local activity_type = activities[i].type
  if activity_type == "Ride" then
    real_km = real_km + activities[i].distance
  elseif activity_type == "VirtualRide" then
    virtual_km = virtual_km + activities[i].distance
  end
end

real_km = real_km / 1000
virtual_km = virtual_km / 1000

local total = real_km + virtual_km

print("total = ", total)
print("real = ", real_km)
print("virtual = ", virtual_km)

os.exit(0)
