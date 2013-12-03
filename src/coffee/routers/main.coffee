define (require) ->
	Backbone = require 'backbone'
	viewManager = require 'hilib/managers/view'
	Pubsub = require 'hilib/mixins/pubsub'
	history = require 'hilib/managers/history'

	Views =
		Home: require 'views/home'
		Login: require 'views/login'
		Highlighter: require 'views/hilib/highlighter'
		Form: require 'views/hilib/form'
		Pagination: require 'views/hilib/pagination'

	class MainRouter extends Backbone.Router

		initialize: ->
			_.extend @, Pubsub

			@on 'route', => history.update()

			@subscribe 'authorized', => 
				url = history.last() ? ''
				@navigate url, trigger: true
			@subscribe 'unauthorized', =>
				sessionStorage.clear()
				@navigate 'login', trigger: true if Backbone.history.fragment isnt 'login' # Check for current route cuz unauthorized can be fired multiple times (from multiple sources)

		'routes':
			'': 'home'
			'login': 'login'
			'hilib/form': 'form'
			'hilib/highlighter': 'highlighter'
			'hilib/pagination': 'pagination'

		home: ->
			viewManager.show '#main',  Views.Home

		login: ->
			viewManager.show '#main',  Views.Login

		highlighter: ->
			viewManager.show '#main', Views.Highlighter

		form: ->
			viewManager.show '#main', Views.Form

		pagination: ->
			viewManager.show '#main', Views.Pagination