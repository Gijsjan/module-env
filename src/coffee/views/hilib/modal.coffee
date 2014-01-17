define (require) ->

	Views =
		Base: require 'views/base'

	Modal = require 'hilib/views/modal/main'

	class HilibModal extends Views.Base

		initialize: ->
			super

			@render()

		render: ->
			modal = new Modal
				title: "My title!"
				html: 'lalala'
				submitValue: 'OK'
			modal.on 'cancel', =>
			modal.on 'submit', => modal.messageAndFade 'success', 'Modal submitted!'

			@el.appendChild modal.el

			@