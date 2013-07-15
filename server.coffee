_ = require 'underscore'

express = require('express')
app = express()

app.use express.bodyParser()

staticDir = process.argv[2] || 'dev'
port = if staticDir is 'dev' then 3000 else 3001

app.use express.static(__dirname + '/' + staticDir)

app.all '/*', (req, res) ->
  res.sendfile 'index.html', root: __dirname+'/'+staticDir
				

app.listen port, 'localhost'
console.log "Server running #{staticDir}/ on http://localhost:#{port}"