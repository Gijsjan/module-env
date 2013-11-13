define (require) ->
	Backbone = require 'backbone'
	viewManager = require 'managers/view'
	Pubsub = require 'pubsub'

	Views =
		Home: require 'views/home'
		Login: require 'views/login'
		Highlighter: require 'views/hilib/highlighter'

	class MainRouter extends Backbone.Router

		initialize: ->
			_.extend @, Pubsub

			@subscribe 'authorized', => @navigate '', trigger: true
			@subscribe 'unauthorized', =>
				sessionStorage.clear()
				@navigate 'login', trigger: true if Backbone.history.fragment isnt 'login' # Check for current route cuz unauthorized can be fired multiple times (from multiple sources)

		'routes':
			'': 'home'
			'login': 'login'
			'form': 'form'
			'hilib/highlighter': 'highlighter'

		home: ->
			viewManager.show Views.Home

		login: ->
			viewManager.show Views.Login

		form: ->
			console.log 'formsst'

		highlighter: ->
			viewManager.show Views.Highlighter