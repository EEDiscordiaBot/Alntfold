local discordia = require("Discordia")
local client = discordia.Client()
local prefix = "="
local commandlist = {
	["help"] = {"Help", "Alntfold is a simple, open-source Discord administration bot with a wide breadth of features made with the Discordia library. View its repository on Github: https://github.com/EEDiscordiaBot/Alntfold\n\nThis bot's prefix is `"..prefix.."`.\n\nNeed help with a specific command? You can do: `"..prefix.."help commandname`\n\nExample: '"..prefix.."help ban`", "15466472", "`help`", "`help`", "• None"}
	["ban"] = {"Ban", "Bans member(s).", "15466472", "`"..prefix.."ban [Mentions]`", "`"..prefix.."ban <@240291244306071552>, <@765819682585706496>`", "• Ban Members Permission"}
}

local commands = {
	["help"] = function(message)
		local command = command[string.sub(message.content, 7)]
		message.channel:send {
			embeds = {
				title = command[1]
				description = command[2]
				color = command[3]
				fields = {
					{name = "Syntax", value = command[4], inline = true}
					{name = "Example", value = command[5], inline = true}
					{name = "Requirements", value = command[6], inline = false}
				}
			}
		}
	end

	["ban"] = function(message)
		if message.author:hasPermission(0x00000004) then
			for i,j in pairs(message.mentionedUsers) do
				if message.guild.members:get(message.author.id).highestRole > message.guild.members:get(j.id).highestRole then
					message.guild:banUser(j.id, reason, purge)
				end
			end
		end
	end
}

client:on("messageCreate" function(message)
	if string.sub(message.content, 1, 1) == prefix and message.author.bot == false then
		local command = string.sub(message.content, 2, string.lower(string.find(message.content, " ")))
		if commandlist[command] then
			local helpCommand = string.sub(message.content, string.lower(string.find(message.content, " ")))
				commands[command](message)
		end
	end
end)

