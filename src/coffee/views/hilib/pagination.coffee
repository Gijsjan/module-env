define (require) ->

	Views =
		Base: require 'views/base'

	Pagination = require 'hilib/views/pagination/main'

	class HilibPagination extends Views.Base

		initialize: ->
			super

			@render()

		render: ->
			pBasic = new Pagination
				rowCount: 12
				resultCount: 500
			@listenTo pBasic, 'change:pagenumber', (pagenumber) -> console.log pagenumber

			h2 = document.createElement('h2')
			h2.innerHTML = 'Basic'
			@el.appendChild h2
			@el.appendChild pBasic.el

			pAdvanced = new Pagination
				rowCount: 4
				resultCount: 17
				step10: false
				triggerPagenumber: false
			@listenTo pAdvanced, 'prev', -> console.log 'prev'
			@listenTo pAdvanced, 'next', -> console.log 'next'

			h2 = document.createElement('h2')
			h2.innerHTML = 'Advanced'
			@el.appendChild h2
			@el.appendChild pAdvanced.el

			@