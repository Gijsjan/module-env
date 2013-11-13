(function() {
  require.config({
    paths: {
      'faceted-search': '../lib/faceted-search/stage/js/main',
      'jquery': '../lib/jquery/jquery',
      'underscore': '../lib/underscore-amd/underscore',
      'backbone': '../lib/backbone-amd/backbone',
      'domready': '../lib/requirejs-domready/domReady',
      'managers': '../lib/managers/dev',
      'helpers': '../lib/helpers/dev',
      'hilib': '../lib/hilib/compiled',
      'text': '../lib/requirejs-text/text',
      'html': '../html'
    },
    shim: {
      'underscore': {
        exports: '_'
      },
      'backbone': {
        deps: ['underscore', 'jquery'],
        exports: 'Backbone'
      }
    }
  });

  require(['domready', 'app'], function(domready, app) {
    return domready(function() {
      return app.initialize();
    });
  });

}).call(this);
