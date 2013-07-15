define (require) ->
	$ = require 'jquery'
	config = require 'config'
	token = require 'managers/token'

	get: (args) ->
		@fire 'get', args

	post: (args) ->
		@fire 'post', args

	put: (args) ->
		@fire 'put', args

	fire: (type, args) ->
		args.url = config.baseUrl+args.url # Append baseUrl to url

		ajaxArgs =
			type: type
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader 'Authorization', "SimpleAuth #{token.get()}"

		ajaxArgs = $.extend ajaxArgs, args

		$.ajax ajaxArgs
			