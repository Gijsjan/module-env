define (require) ->

	config = require 'config'

	token = require 'managers/token'

	Views =
		Base: require 'views/base'
		FacetedSearch: require 'faceted-search'

	Templates =
		Home: require 'text!html/home.html'

	class Home extends Views.Base

		initialize: ->
			super

			@render()

		render: ->
			rtpl = _.template Templates.Home
			@$el.html rtpl

			facetedSearch = new Views.FacetedSearch
				el: @$('#placeholder')
				baseUrl: config.baseUrl
				searchUrl: 'projects/32/search'
				token: token.get()

			facetedSearch.on 'faceted-search:results', (results) =>
				@$('#results ul.results').html ''
				_.each results.results, (result) ->
					@$('#results ul.results').append $('<li />').html result.name

			@