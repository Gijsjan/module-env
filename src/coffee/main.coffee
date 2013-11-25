require.config 
    paths:
        'faceted-search': '../lib/faceted-search/stage/js/main'
        'jquery': '../lib/jquery/jquery'
        'underscore': '../lib/underscore-amd/underscore'
        'backbone': '../lib/backbone-amd/backbone'
        'domready': '../lib/requirejs-domready/domReady'
        'hilib': '../lib/hilib/compiled'
        # 'text': '../lib/requirejs-text/text'
        'tpls': '../templates'
        'jade': '../lib/jade/runtime'
        'html': '../html'

    shim:
        'underscore':
            exports: '_'
        'backbone':
            deps: ['underscore', 'jquery']
            exports: 'Backbone'
        # 'faceted-search':
        #     deps: ['backbone']
        #     exports: 'faceted-search'

require ['domready', 'app'], (domready, app) ->
    domready ->
        app.initialize()