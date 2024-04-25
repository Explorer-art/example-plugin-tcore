---------------------------- Информация о плагине ----------------------------

local PLUGIN_NAME = "Example"
local DESCRIPTION = "Это пример кастомного плагина для ядра TCORE, но он так-же практически полностью совместим с стандартным ядром."
local VERSION = "1.0"
local AUTHOR = "Truzme_"

------------------------------------------------------------------------------

local M = {}

local api

local function command(client) -- пример команды
	-- Переменная client - это клиент игрока который ввел данную команду
	local client_data = api.get_client_data(client) -- получаем данные клиента
	local client_name = client_data.name -- ник
	local client_uuid = client_data.uuid -- UUID
	local client_land = client_data.land -- цивилизация

	-- пишем игроку сообщение в чат
	api.call_function("chat_message", "Ник: "..client_name.."\nUUID: "..client_uuid.."\nЦивилизация: "..client_land, "system", client)
end

-- функия для перезагрузки плагина
-- function M.reload()
-- end

function M.init(_api) -- инициализация плагина
	api = _api

	-- Параметр false указыает будет ли это команда доступна по стандарту всем игрокам или нет. true - да, false - нет
	-- В данном случае не будет
	api.register_command("/command", command, false, "- описание тестовой команды") -- регистрируем команду
end

function M.on_player_registered(client) -- данная функция сразу выполнится когда игрок зайдет на сервер
	local client_data = api.get_client_data(client)
	local client_name = client_data.name

	-- В чат можно писать разноцветные сообщения с помощью конструкции <color=цвет></color>
	api.call_function("chat_message", "<color=yellow>Игрок "..client_name.." зашёл на сервер</color>", "system") -- это сообщение отправится в чат всем игрокам
end

function M.on_player_disconnected(client)
	local client_data = api.get_client_data(client)
	local client_name = client_data.name

	-- Так же, можно указать HEX код цвета
	api.call_function("chat_message", "<color=#FF0000>Игрок "..client_name.." вышел с сервера</color>", "system") -- это сообщение отправится в чат всем игрокам
end

return M