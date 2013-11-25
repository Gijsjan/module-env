define (require) ->

	Views =
		Base: require 'views/base'

	tpls = require 'tpls'

	class HilibHighlighter extends Views.Base

		initialize: ->
			super

			@render()

		render: ->
			rtpl = tpls['highlighter']()
			@$el.html rtpl
			@