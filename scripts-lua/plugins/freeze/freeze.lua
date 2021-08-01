--[[
	freeze - Freezes screen

	Copyright (C) 2021 Jacek Jendrzej 'satbaby'
	Copyright (C) 2021 Sven Hoefer 'vanhofen'

	License: WTFPLv2
]]

local n = neutrino()

if _curl == nil then
	_curl = curl.new()
end

local ret, data = _curl:download {url = "http://127.0.0.1/control/screenshot", A = "Mozilla/5.0;", maxRedirs = 5, followRedir = true}
if ret == CURL.OK and data == "ok" then
	local fh = filehelpers.new()
	local ss = "/tmp/screenshot.png"
	local sf = "/tmp/screenfreeze.png"
	if fh:exist(ss, "f") then
		local cp = cpicture.new{parent = nil, x = 0, y = 0, dx = 0, dy = 0, image = ss}
		cp:paint()
		fh:cp(ss, sf, "a")
		os.remove(ss)
		local msg, data = nil, nil
		repeat
			msg, data = n:GetInput(500)
		until msg == RC.ok or msg == RC.home or msg == RC.setup
		cp:hide()
	end
end