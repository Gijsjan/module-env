define (require) ->

	viewManager = require 'hilib/managers/view'
	jsoneditor = require 'jsoneditor'

	Views =
		Base: require 'views/base'
		Combolist: require 'hilib/views/form/combolist/main'
		Editablelist: require 'hilib/views/form/editablelist/main'
		Autosuggest: require 'hilib/views/form/autosuggest/main'

	tpls = require 'tpls'

	class HilibForm extends Views.Base

		className: 'hilib form'

		initialize: ->
			super



			@render()

		render: ->
			rtpl = tpls['hilib/form']()
			@el.innerHTML = rtpl

			@renderAutocompletes()
			@renderEditablelists()
			@renderCombolists()


			@editor = new jsoneditor.JSONEditor @el.querySelector('.response')
			
			@

		renderAutocompletes: ->
			# DEFAULT
			autosuggest = viewManager.show @el.querySelector('.autosuggest-placeholder'), Views.Autosuggest,
				# value: 'Gijs'
				config:
					data: ['Gijs', 'Jona', 'Bram', 'Hayco', 'Martijn', 'Meindert']

			@listenTo autosuggest, 'change', (changes) => @editor.set changes


			# ADVANCED
			autosuggest = viewManager.show @el.querySelector('.advanced-autosuggest-placeholder'), Views.Autosuggest,
				value: ['Gijs', 'Jona']
				config:
					data: ['Gijs', 'Jona', 'Bram', 'Hayco', 'Martijn', 'Meindert']
					settings:
						placeholder: 'Select a colleague'
						mutable: true
						editable: true
						confirmRemove: true


			@listenTo autosuggest, 'change', (changes) => @editor.set changes
			@listenTo autosuggest, 'edit', (response) => @editor.set response

			# ADVANCED 2
			autosuggest = viewManager.show @el.querySelector('.advanced2-autosuggest-placeholder'), Views.Autosuggest,
				value: ['Gijs', 'Jona']
				config:
					data: ['Gijs', 'Jona', 'Bram', 'Hayco', 'Martijn', 'Meindert']
					settings:
						placeholder: 'Select a colleague'
						mutable: true
						editable: true
						defaultAdd: false


			@listenTo autosuggest, 'change', (changes) => @editor.set changes
			@listenTo autosuggest, 'add', (response) => @editor.set response
			@listenTo autosuggest, 'edit', (response) => @editor.set response

		renderEditablelists: ->
			# DEFAULT
			editablelist = viewManager.show @el.querySelector('.editablelist-placeholder'), Views.Editablelist,
				value: ['Gijs', 'Jona', 'Bram', 'Hayco', 'Martijn', 'Meindert']

			@listenTo editablelist, 'change', (changes) -> @editor.set changes

			# ADVANCED
			editablelist = viewManager.show @el.querySelector('.advanced-editablelist-placeholder'), Views.Editablelist,
				value: ['Gijs', 'Jona', 'Bram', 'Hayco', 'Martijn', 'Meindert']
				config:
					settings:
						placeholder: 'Add colleague'
						confirmRemove: true

			@listenTo editablelist, 'change', (changes) -> @editor.set changes
			@listenTo editablelist, 'confirmRemove', (id, confirm) =>
				confirm() if window.confirm('Removing '+id+', sure?')

		renderCombolists: ->
			# DEFAULT
			combolist = viewManager.show @el.querySelector('.combolist-placeholder'), Views.Combolist,
				value: ['Gijs', 'Jona']
				config:
					data: ['Gijs', 'Jona', 'Bram', 'Hayco', 'Martijn', 'Meindert']

			@listenTo combolist, 'change', (changes) -> @editor.set changes

			# ADVANCED
			combolist = viewManager.show @el.querySelector('.advanced-combolist-placeholder'), Views.Combolist,
				value: ['Gijs', 'Jona']
				config:
					data: ['Gijs', 'Jona', 'Bram', 'Hayco', 'Martijn', 'Meindert']
					settings:
						placeholder: 'Add colleague'
						mutable: true
						confirmRemove: true

			@listenTo combolist, 'change', (changes) -> @editor.set changes
			@listenTo combolist, 'confirmRemove', (id, confirm) =>
				confirm() if window.confirm('Removing '+id+', sure?')
