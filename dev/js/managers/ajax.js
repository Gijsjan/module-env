(function() {
  define(function(require) {
    var $, config, token;
    $ = require('jquery');
    config = require('config');
    token = require('managers/token');
    return {
      get: function(args) {
        return this.fire('get', args);
      },
      post: function(args) {
        return this.fire('post', args);
      },
      put: function(args) {
        return this.fire('put', args);
      },
      fire: function(type, args) {
        var ajaxArgs;
        args.url = config.baseUrl + args.url;
        ajaxArgs = {
          type: type,
          dataType: 'json',
          beforeSend: function(xhr) {
            return xhr.setRequestHeader('Authorization', "SimpleAuth " + (token.get()));
          }
        };
        ajaxArgs = $.extend(ajaxArgs, args);
        return $.ajax(ajaxArgs);
      }
    };
  });

}).call(this);
