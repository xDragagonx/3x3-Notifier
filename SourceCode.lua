--VARIABLES
local wtMessage = mainForm:GetChildChecked("Text", false)

local cooldownTimer3x3 = 0
local timerMessage = 0
local firstInit = false
local skirmishTimer = nil
local activeTimer = false

function Main()
	
	-- ChatLog(messageNotify)
	-- wtMessage:SetVal("value", messageNotify)
	-- wtMessage:Show(true)
	matchMaking.ListenEvents(true)
	common.RegisterEventHandler(EVENT_MATCH_MAKING_JOIN_TIME_CHANGED, "EVENT_MATCH_MAKING_JOIN_TIME_CHANGED") --https://alloder.pro/md/LuaApi/EventMatchMakingJoinTimeChanged.html
	--Test()
end

function Test()
	local eventId = matchMaking.GetEvents()
	if eventId then
		--GOES THROUGH ALL INSTANCES
		for k,v in pairs(eventId) do
  		--ChatLog("Id of event: "..v)
		local eventIdInfo = matchMaking.GetEventInfo(v) --gets all info out of each id, linked to each instance
		ChatLog(eventIdInfo)
		local eventName = userMods.FromWString(common.ExtractWStringFromValuedText(eventIdInfo.name)) --Takes only the name out of each instance
			if eventName == "3x3 Combat" then --Compares each instance name to "3x3 Combat"
				local joinTime = matchMaking.GetEventJoinTimeEstimate( eventIdInfo.id )
				ChatLog(eventIdInfo) --Display all info about 3x3 Combat
				ChatLog(joinTime)
			end		
		end
	end
end

function EVENT_MATCH_MAKING_JOIN_TIME_CHANGED(params)
	-- if firstInit == false then --used to catch the first event whenever you log in, swap reinc or relog.
	-- 	firstInit = true
	-- 	return --exits function
	-- end
	--ChatLog("at function "..tostring(firstInit))
	--ChatLog("A timer changed")
	--It is sent every time the estimate of the waiting time for joining an instance event changes in any way (added-removed-changed). Receiving and tracking information about instance events must be enabled
	local eventId = params.eventId
	local eventInfo = matchMaking.GetEventInfo(eventId)
	if eventInfo then
		-- ChatLog(eventId)
		-- ChatLog(autoDepartTime)
		-- ChatLog("eventInfo has a value")
		local skirmishName = userMods.FromWString(common.ExtractWStringFromValuedText( eventInfo.name)) --THIS IS HOW YOU CONVERT VALUEDTEXT TO WSTRING
		skirmishTimer = matchMaking.GetEventJoinTimeEstimate(eventId)
		-- ChatLog(skirmishName)
		-- ChatLog(skirmishTimer.time," min.")
		if skirmishName == locales["3x3Combat"] then --filters for specific skirmish
			if skirmishTimer then
				if skirmishTimer.time > 1 and activeTimer == false then
					ChatLog(locales["signed"],skirmishName)
					local messageNotify = userMods.ToWString(locales["signed"].." "..skirmishName)
					wtMessage:SetVal("value",messageNotify)
					wtMessage:Show(true)
					activeTimer = true
					common.RegisterEventHandler(HideMessageTimer, "EVENT_SECOND_TIMER")
				elseif skirmishTimer.time == nil then
					activeTimer = false
				end
			end			
		end
	end
end

function HideMessageTimer()
	--ChatLog(timer)
	if timerMessage == 4 then
		wtMessage:Show(false)
		timerMessage = 0
		common.UnRegisterEventHandler(HideMessageTimer, "EVENT_SECOND_TIMER")
		cooldownTimer3x3 = 0
	else
		timerMessage = timerMessage + 1
	end
end

if (avatar.IsExist()) then
	ChatLog("3x3 Notifier loaded.")
	Main()
else
	ChatLog("3x3 Notifier loaded")
	common.RegisterEventHandler(Main, "EVENT_AVATAR_CREATED")
end