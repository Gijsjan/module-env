define (require) ->
    Backbone = require 'backbone'

    MainRouter = require 'routers/main'

    Models =
        currentUser: require 'models/currentUser'

    initialize: ->
        mainRouter = new MainRouter()

        Backbone.history.start pushState: true

        Models.currentUser.authorize() 

        $(document).on 'click', 'a:not([data-bypass])', (e) ->
            href = $(@).attr 'href'
            
            if href?
                e.preventDefault()

                Backbone.history.navigate href, 'trigger': true