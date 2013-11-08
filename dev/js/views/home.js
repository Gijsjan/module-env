(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Home, Templates, Views, config, token, _ref;
    config = require('config');
    token = require('managers/token');
    Views = {
      Base: require('views/base'),
      FacetedSearch: require('faceted-search')
    };
    Templates = {
      Home: require('text!html/home.html')
    };
    return Home = (function(_super) {
      __extends(Home, _super);

      function Home() {
        _ref = Home.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Home.prototype.initialize = function() {
        Home.__super__.initialize.apply(this, arguments);
        return this.render();
      };

      Home.prototype.render = function() {
        var rtpl,
          _this = this;
        rtpl = _.template(Templates.Home);
        this.$el.html(rtpl);
        this.facetedSearch = new Views.FacetedSearch({
          el: this.$('#placeholder'),
          baseUrl: config.baseUrl,
          searchPath: 'projects/32/search',
          token: token.get(),
          textSearchOptions: {
            term: '*'
          }
        });
        this.facetedSearch.on('results:change', function(results) {
          var next, prev;
          _this.$('#results ul.results').html('');
          _.each(results.get('results'), function(result) {
            return this.$('#results ul.results').append($('<li />').html(result.name));
          });
          prev = $('<button />').html('prev');
          prev.click(function(ev) {
            return _this.facetedSearch.prev();
          });
          next = $('<button />').html('next');
          next.click(function(ev) {
            return _this.facetedSearch.next();
          });
          _this.$('#results ul.results').append(prev);
          return _this.$('#results ul.results').append(next);
        });
        this.facetedSearch.on('unauthorized', function() {
          return _this.publish('unauthorized');
        });
        this.facetedSearch.on('all', function() {
          return console.log('Module Env | FacetedSearch Event: ', arguments);
        });
        return this;
      };

      Home.prototype.events = {
        'click button.reset': function(ev) {
          return this.facetedSearch.reset();
        }
      };

      return Home;

    })(Views.Base);
  });

}).call(this);
