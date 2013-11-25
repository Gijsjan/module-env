define (require) ->
	BaseView = require 'views/base'

	currentUser = require 'models/currentUser'

	tpls = require 'tpls'
	
	class Login extends BaseView

		className: 'row span3'

		events:
			'click input#submit': 'submit'

		submit: (ev) ->
			ev.preventDefault()

			currentUser.login()

			# @publish 'navigate:project'

		initialize: ->
			super
			
			@render()

		render: ->
			rtpl = tpls['home']()
			@$el.html rtpl

			@