define (require) ->

	config = require 'config'

	token = require 'hilib/managers/token'

	Views =
		Base: require 'views/base'
		FacetedSearch: require 'faceted-search'

	tpls = require 'tpls'

	class Home extends Views.Base

		initialize: ->
			super

			@render()

		render: ->
			rtpl = tpls['home']()
			@$el.html rtpl

			# facetedSearch = new Views.FacetedSearch
			# 	el: @$('#placeholder')
			# 	baseUrl: 'http://demo17.huygens.knaw.nl/'
			# 	searchUrl: 'repository/search'
			# 	queryOptions:
			# 		term: '*'
			# 		typeString: 'atlgarchive'
			# 		sort: 'id'
			@facetedSearch = new Views.FacetedSearch
				el: @$('#placeholder')
				baseUrl: config.baseUrl
				searchPath: 'projects/16/search'
				token: token.get()
				textSearchOptions:
					term: '*'
					searchInAnnotations: false
					searchInTranscriptions: false
					textLayers: ['Diplomatic', 'Critical', 'Translation', 'Comments']

			@facetedSearch.on 'results:change', (results) =>
				@$('#results ul.results').html ''
				_.each results.get('results'), (result) ->
					@$('#results ul.results').append $('<li />').html result.name
				
				prev = $('<button />').html 'prev'
				prev.click (ev) => @facetedSearch.prev()
				next = $('<button />').html 'next'
				next.click (ev) => @facetedSearch.next()

				@$('#results ul.results').append prev
				@$('#results ul.results').append next

			@facetedSearch.on 'unauthorized', => @publish 'unauthorized'

			@facetedSearch.on 'all', -> console.log 'Module Env | FacetedSearch Event: ', arguments

			@

		# ### Events
		events:
			'click button.reset': (ev) -> @facetedSearch.reset()