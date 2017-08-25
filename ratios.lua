local pattern = "%d%dx%d%d"

local crankset = {
  ["50x34"] = { 50, 34 },
  ["52x36"] = { 52, 36 },
  ["53x39"] = { 53, 39 },
}

local cassette = {
  ["11x25"] = { 11, 12, 13, 14, 15, 17, 19, 21, 23, 25 },
  ["11x28"] = { 11, 12, 13, 14, 15, 17, 19, 21, 24, 28 },
  ["11x32"] = { 11, 12, 13, 14, 16, 18, 20, 22, 25, 28, 32 },
}

local function show_ratios (chainring, cassette)
  for i = 1, #cassette do
    local v = cassette[i]
    io.write(string.format("%d x %d = %.2f\t", chainring, v, chainring / v))
  end
  io.write("\n")
end

if #arg ~= 2 then
  print("Usage: lua ratios.lua <big_ringxsmall_ring> <small_cogxbig_cog>")
  print("Example: lua ratios.lua 50x34 11x32")
  os.exit(1)
end

local crank, k7 = arg[1], arg[2]

if not string.match(crank, pattern) or not crankset[crank] then
  print("Invalid crankset")
  os.exit(2)
end

if not string.match(k7, pattern) or not cassette[k7] then
  print("Invalid K7")
  os.exit(3)
end

for i = 1, #crankset[crank] do
  show_ratios(crankset[crank][i], cassette[k7])
end
