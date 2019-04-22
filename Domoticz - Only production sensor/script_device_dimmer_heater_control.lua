-- Control ESP8266 with Dimmer

-- Connection  : 
-- GND > GND
-- VCC > 3V 
-- ZC > D5
-- PWM > D6 

-- variables  for ESP8266 connection
IP="192.168.1.75"
IDXNAME="Relay délestage"

-- soft fuse 
fuse=2 -- in A 
load=800 -- in watt

valuemax=(2*220/800*100)

-- main program 

commandArray = {}

if (devicechanged[IDXNAME]) then

		-- get Domoticz Dimmer information switch 
	val_production = tonumber(otherdevices_svalues[IDXNAME])

		if val_production > valuemax then
			val_production = valuemax
			commandArray[IDXNAME]='Set Level '..val_production
		print("security mode")
		end
		

		-- send information to esp8266 dimmer
		commandArray['OpenURL']=IP..'/?POWER='..val_production
		
		-- log action
		print("commande send to :"..val_production.."%")

end
	
return commandArray

