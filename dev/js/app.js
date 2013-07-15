(function() {
  define(function(require) {
    var Backbone, MainRouter, Models;
    Backbone = require('backbone');
    MainRouter = require('routers/main');
    Models = {
      currentUser: require('models/currentUser')
    };
    return {
      initialize: function() {
        var mainRouter;
        mainRouter = new MainRouter();
        Backbone.history.start({
          pushState: true
        });
        Models.currentUser.authorize();
        return $(document).on('click', 'a:not([data-bypass])', function(e) {
          var href;
          href = $(this).attr('href');
          if (href != null) {
            e.preventDefault();
            return Backbone.history.navigate(href, {
              'trigger': true
            });
          }
        });
      }
    };
  });

}).call(this);
