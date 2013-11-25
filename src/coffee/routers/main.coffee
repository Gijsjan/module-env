define (require) ->
	Backbone = require 'backbone'
	viewManager = require 'hilib/managers/view'
	Pubsub = require 'hilib/mixins/pubsub'

	Views =
		Home: require 'views/home'
		Login: require 'views/login'
		Highlighter: require 'views/hilib/highlighter'
		Form: require 'views/hilib/form'

	class MainRouter extends Backbone.Router

		initialize: ->
			_.extend @, Pubsub

			@subscribe 'authorized', => 
				# @navigate '', trigger: true
			@subscribe 'unauthorized', =>
				sessionStorage.clear()
				@navigate 'login', trigger: true if Backbone.history.fragment isnt 'login' # Check for current route cuz unauthorized can be fired multiple times (from multiple sources)

		'routes':
			'': 'home'
			'login': 'login'
			'hilib/form': 'form'
			'hilib/highlighter': 'highlighter'

		home: ->
			viewManager.show '#main',  Views.Home

		login: ->
			viewManager.show '#main',  Views.Login

		highlighter: ->
			viewManager.show '#main', Views.Highlighter

		form: ->
			viewManager.show '#main', Views.Form