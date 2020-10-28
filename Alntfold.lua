local Discordia = require("Discordia")
local Client = Discordia.Client()
local Debug = 0
local Prefix = "|"
local PrefixLength
PrefixLength = string.len(Prefix)
local HelpInformation = {
	["help"] = {"Command Name", "Description - You shouldn't see this...", "Syntax", "Example", "Permissions Needed"},
	["ban"] = {"Ban", "This command allows you to ban multiple members via pinging them.", "`"..Prefix.."ban @Member`", Prefix.."ban <@769121249212629013>", "• Ban Members"}
}

local Commands = {
	  ["help"] = function(Message)
		if string.len(Message.content) > PrefixLength + 4 and HelpInformation[string.sub(Message.content, (PrefixLength + 6))] then
			local HelpInfo = HelpInformation[string.sub(Message.content, (PrefixLength + 6))]
			Message.channel: send {
				embed = {
					title = HelpInfo[1],
					description = HelpInfo[2],
					color = 13631451,
					fields = {
						{name = "Syntax:", value = HelpInfo[3], inline = true},
						{name = "Example:", value = HelpInfo[4], inline = true},
						{name = "Permission(s) Needed:", value = HelpInfo[5].."\n• Note that anyone with the Administrator permission can use any command unless explicitly stated that only the guild owner has the power to use it.", inline = false}
					}
				}
			}
				
		elseif string.len(Message.content) > PrefixLength + 5 and not HelpInformation[string.sub(Message.content, (PrefixLength + 6))] then
			Message.channel: send {
				embed = {
					title = "No Help Command Found",
					description = "No information for this command exists. Either it does not exist or is still developing.",
					color = 11022898
				}
			}

		else
			Message.channel: send {
				embed = {
					title = "Alntfold",
					description = "Alntfold is a simple, open-source Discord administration bot with a wide breadth of features made with the Discordia library.\n\nYou can check out its Github here: https://github.com/EEDiscordiaBot/Alntfold\n\nNeed help with a specifc command? You can do:\n`"..Prefix.."help CommandName`\n to get specific information about a command.\n\n**Example:**\n`"..Prefix.."help ban`",
					color = 13631451,
					}
			}
		end
	end,

	["ban"] = function(Message)
		if Message.guild.members:get(Message.author.id):hasPermission("banMembers") then
			for i,j in pairs(Message.mentionedUsers) do
				if Message.guild.members:get(j.id).highestRole.position < Message.guild.members:get(Message.author.id).highestRole.position then
					Message.guild:banUser(j.id)
				end 
			end
		end
	end,
}


Client:on("messageCreate", function(Message)
	if string.sub(Message.content, 1, 1) == Prefix and Message.author.bot == false then
		if string.find(Message.content, " ") then
			local Command = string.sub(Message.content, (PrefixLength+1), (string.find(Message.content, " ")-1))
			if Commands[Command] then
				Commands[Command](Message)
			end
		else
			local Command = string.sub(Message.content, (PrefixLength+1))
			if Commands[Command] then
				Commands[Command](Message)
			end
		end
	end
end)

Client:run("Bot NzY5MTIxMjQ5MjEyNjI5MDEz.X5KZ-w.YY5L9eEbEGgGz6zpuQqmYjvrvxY")
	
