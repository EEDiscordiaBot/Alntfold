local Discordia = require("Discordia")
local Client = Discordia.Client()
local Prefix = "|"

local function Error(Channel, ErrorType, ErrorRemedy)
	Channel:send{
		embed = {
			title = "Error - "..ErrorType,
			description = ErrorRemedy,
			color = 8850187,
		}
	}
end

local function CatastrophicErorr(Channel)
	Channel:send{
				embed = {
						title = "A Catastrophic Error Has Occured",
						description = "You really shouldn't be reading this. We don't know what happened or why. Please contact `EE#3373` if you receive this error, along with information such as what exactly you did.",
						color = 8850187	
				}
	}
end

local Commands = {
	["a"] = function(Message) -- Placeholder for testing
		Message.channel:send(":white_check_mark:")
	end
}

Client:on("messageCreate", function(Message)
	if not Message.author.bot and string.sub(Message.content, 1, 1) == Prefix then
		local Command

		if SpaceFind then
			Command = string.sub(Message.content, 2, (string.find(Message.content, " ") - 1))
		else
			Command = string.sub(Message.content, 2)
		end
		
		if Commands[Command] then
			Commands[Command](Message)
		else
			Error(Message.channel, "Invalid Command", "You can run `"..Prefix.."command list` to get a list of valid commands.")
		end
	end
end)

Client:run("Bot XXXXXXXXXXXXXXXXXXXXXXXX.XXXX-X.XXXXXXXXXXXXXXXXXXXXXXXXX-X") -- Replace with your bot token from https://discord.com/developers/applications.
