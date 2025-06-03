This Script is for Gens Emulators with Lua Script support ( Rens Re-Recording , Gensr57Shell etc) 

It searches in rom for the the current CRAM data. If found returns its offset in ROM:

-- one time get the rom data as a hex string
rom_string = Get_Rom_Data_String()

-- get cram as hex string
cram_string = Get_CRAM_String()

-- search for cram in rom
find = string.find(rom_string,cram_string)

if find ~= nil then
  -- divide by two becuase each byte of data is two hex digits / nybles 
  -- two chars
  print(hex(find/2))
end


