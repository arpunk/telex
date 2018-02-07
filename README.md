telex
=====

Telex exposes a very thin layer over the Telegram Bot API HTTP
interface, it does not care about any data bindings over the interface
and tries to abstract away only the boilerplate for building, sending
and serializing the API requests.

## Installation
```Erlang
{deps, [telex]}.
```

## Usage

### Get the bot details
```LFE
(telex:request "bot:token" "getMe")

#(ok
  #M(#"username" #"bot_bot" #"is_bot" true #"id" 123456789
     #"first_name" #"BotBot"))
```

### Sending a message
```LFE
(telex:request "bot:token" "sendMessage" #M(chat_id 123456789 text "hola mundo"))

#(ok
  #M(#"text" #"hello world" #"message_id" 86
     #"from"
     #M(#"username" #"bot_bot" #"is_bot" true
        #"id" 525399965 #"first_name" #"BotBot")
     #"date" 1517968605
     #"chat"
     #M(#"username" #"username" #"type" #"private"
        #"last_name" #"First" #"id" 123456789
        #"first_name" #"Last")))
```

## References

- [Telegram API specs](https://core.telegram.org/bots/api)
- [Introduction to Telegram bots](https://core.telegram.org/bots)

## License

Copyright (c) 2018 Ricardo Lanziano

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the LICENSE file for more details.
