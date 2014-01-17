define (require) ->

	Views =
		Base: require 'views/base'

	SuperTinyEditor = require 'hilib/views/supertinyeditor/supertinyeditor'

	class HilibSupertinyeditor extends Views.Base

		initialize: ->
			super

			@render()

		render: ->
			# model = new 
			# 	body: 'some html 2'
			console.log 'render'
			ste = new SuperTinyEditor
				controls:		['b_save', 'n', 'bold', 'italic', 'underline', 'strikethrough', '|', 'subscript', 'superscript', 'unformat', '|', 'diacritics', '|', 'undo', 'redo', 'wordwrap']
				cssFile:		'/css/main.css'
				html:			'<div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div>'
				htmlAttribute:	'body'
				model:			new Backbone.Model body: '<div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines. Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div><br><div class="line">Dit is een echte lijn, je kent ze wel, de enige echte lines.</div>'

			@el.appendChild ste.el

			@