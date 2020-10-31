local Discordia = require("Discordia")
local Client = Discordia.Client()
local Prefix = "|"
local Debug = 0

local function Error(Channel, Error)
	Channel:send{
				embed = {
						title = "Error"
						description = Error
						color = 8850187
						}
				}
end


Client:on("messageCreate", function(Message)
	if not Message.author.bot and string.sub(Message, 1, 1) == Prefix then
		local SpaceFind = string.SpaceFind(Message, " ")
		
		if SpaceFind then
			local Command = string.sub(Message, 2, (SpaceFind - 1))
		else
			local Command = string.sub(Message, 2)
		end
		
		if Commands[Command] then
			Commands[command](Message)
		else
			Error(Message.channel, "Invalid command! You can run `"Prefx.."command list` to get a list of valid commands.")
		end
	end
end)

Client:run("Bot ")
