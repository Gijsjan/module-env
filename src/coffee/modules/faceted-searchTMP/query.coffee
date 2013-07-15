# define (require) ->
# 	pubsub = require 'pubsub'
# 	ajax = require 'managers/ajax'

# 	query =
# 		url: ''
# 		get: (queryData, cb) ->
# 			fetchResults = (key) => # GET results from the server
# 				jqXHR = ajax.get
# 					url: @url+'/'+key

# 				jqXHR.done cb

# 			jqXHR = ajax.post
# 				url: @url
# 				contentType: 'application/json; charset=utf-8'
# 				processData: false
# 				data: JSON.stringify queryData

# 			jqXHR.done (data) ->
# 				fetchResults data.key

# 			jqXHR.fail (jqXHR, textStatus, errorThrown) =>
# 				if jqXHR.status is 401
# 					@publish 'unauthorized'

# 	_.extend query, pubsub