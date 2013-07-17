(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, MainRouter, Pubsub, Views, viewManager, _ref;
    Backbone = require('backbone');
    viewManager = require('managers/view');
    Pubsub = require('pubsub');
    Views = {
      Home: require('views/home'),
      Login: require('views/login')
    };
    return MainRouter = (function(_super) {
      __extends(MainRouter, _super);

      function MainRouter() {
        _ref = MainRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      MainRouter.prototype.initialize = function() {
        var _this = this;
        _.extend(this, Pubsub);
        this.subscribe('authorized', function() {
          return _this.navigate('', {
            trigger: true
          });
        });
        return this.subscribe('unauthorized', function() {
          return _this.navigate('login', {
            trigger: true
          });
        });
      };

      MainRouter.prototype['routes'] = {
        '': 'home',
        'login': 'login'
      };

      MainRouter.prototype.home = function() {
        return viewManager.show(Views.Home);
      };

      MainRouter.prototype.login = function() {
        return viewManager.show(Views.Login);
      };

      return MainRouter;

    })(Backbone.Router);
  });

}).call(this);