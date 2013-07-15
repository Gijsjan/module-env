define (require) ->
	Backbone = require 'backbone'
	viewManager = require 'managers/view'
	Pubsub = require 'pubsub'

	Views =
		Home: require 'views/home'
		Login: require 'views/login'

	class MainRouter extends Backbone.Router

		initialize: ->
			_.extend @, Pubsub

			@subscribe 'authorized', => @navigate '', trigger: true
			@subscribe 'unauthorized', => @navigate 'login', trigger: true

		'routes':
			'': 'home'
			'login': 'login'

		home: ->
			viewManager.show Views.Home

		login: ->
			viewManager.show Views.Login