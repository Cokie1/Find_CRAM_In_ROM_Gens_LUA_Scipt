-- GENS_FIND_CRAM_IN_ROM
-- Gens Rerecording / Gens R57shell Mod Lua Script
-- searches for the CRAM data in ROM and returns its location

-- shortcuts
rl = memory.readlong
rb = memory.readbyte

-- ROM Start/End
ROM_START = 0 
ROM_END = rl(0x1a4)


-- Convert to hex string that has a predecing 0 for 08 0D ETC
function hex(v)
	return string.upper(string.format("%02x",v))
end


-- returns the entire rom data has a concat hex string 
-- of every byt read 
function Get_Rom_Data_String()
	local ROM_Table = {}
	for i = ROM_START  , ROM_END  do
		table.insert(ROM_Table,hex(rb(i)))
	end
	
	local rom_str = table.concat(ROM_Table)
	return rom_str 
end

-- get the cram as a hex concat hex string
function Get_CRAM_String()

	local p,t = vdp.readpalette(1,4)

	-- TODO CAN I GET ALL 4 PALLETES RAW DATA IN ONE 
	-- TABLE SO I DONT HAVE TO CONCAT EACH PAL
	-- RESULTING STRING WHICH IS NOT OPTIMAL?

	-- get as raw data
	local pal1 = pal.rawdata(t[1],32)

	local pal2 = pal.rawdata(t[2],32)

	local pal3 = pal.rawdata(t[3],32)
	local pal4 = pal.rawdata(t[4],32)

	
	cram_string = ""
	
	for i,v in pairs(pal1) do
		cram_string = cram_string .. hex(v)
	end

	for i,v in pairs(pal2) do
		cram_string = cram_string .. hex(v)
	end
	for i,v in pairs(pal3) do
		cram_string = cram_string .. hex(v)
	end
	for i,v in pairs(pal4) do
		cram_string = cram_string .. hex(v)
	end

	-- UNUSED CODE
	--local pal1_str = table.concat(pal1)
	--local pal2_str = table.concat(pal2)
	--local pal3_str = table.concat(pal3)
	--local pal4_str = table.concat(pal4)
	--local cram_string =  pal1_str .. pal2_str .. pal3_str .. pal4_str 

	return cram_string
end

-- one time get the rom data as a hex string
rom_string = Get_Rom_Data_String()

-- get cram as hex string
cram_string = Get_CRAM_String()


-- search for cram in rom
find = string.find(rom_string,cram_string)

-- divide by two becuase each byte of data is two hex digits / nybles 
-- two chars
print(hex(find/2))


