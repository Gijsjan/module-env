connect_middleware = require 'my-grunt-modules/connect-middleware'

module.exports = (grunt) ->
	require('load-grunt-tasks') grunt
	require('my-grunt-modules/create-symlinks') grunt

	##############
	### CONFIG ###
	##############

	grunt.initConfig
	
		createSymlinks:
			compiled: [
				src: 'images'
				dest: 'compiled/images'
			,
				src: '~/Projects/faceted-search'
				dest: 'compiled/lib/faceted-search'
			,
				src: '~/Projects/faceted-search/images'
				dest: 'images/faceted-search'
			,
				src: '~/Projects/hilib'
				dest: 'compiled/lib/hilib'
			,
				src: '~/Projects/hilib/images'
				dest: 'images/hilib'
			]
			stage: [{
				src: 'images'
				dest: 'stage/images'
			}]

		connect:
			compiled:
				options:
					port: 3000
					base: 'compiled'
					middleware: connect_middleware
					keepalive: true
			# stage:
			# 	options:
			# 		port: 8001
			# 		base: 'compiled'
			# 		middleware: connect_middleware


		shell:
			'mocha-phantomjs': 
				command: 'mocha-phantomjs -R dot http://localhost:8000/.test/index.html'
				options:
					stdout: true
					stderr: true

			emptystage:
				command:
					'rm -rf stage/*'

			emptycompiled:
				command:
					'rm -rf compiled/*'

			# rsync:
			# 	command:
			# 		'rsync --copy-links --compress --archive --verbose --checksum --exclude=.svn --chmod=a+r stage/ elaborate4@hi14hingtest.huygens.knaw.nl:elab4testFE/'
			# 	options:
			# 		stdout: true

			symlink_compiled_images:
				command: [
					'cd compiled'
					'ln -s ../images images'
				].join '&&'
				
			symlink_stage_images:
				command: [
					'cd stage'
					'ln -s ../images images'
				].join '&&'

			bowerinstall:
				command: 'bower install'
				options:
					stdout: true
					stderr: true

		coffee:
			init:
				files: [
					expand: true
					cwd: 'src/coffee'
					src: '**/*.coffee'
					dest: 'compiled/js'
					rename: (dest, src) -> 
						dest + '/' + src.replace(/.coffee/, '.js') # Use rename to preserve multiple dots in filenames (nav.user.coffee => nav.user.js)
				,
					'.test/tests.js': ['.test/head.coffee', 'test/**/*.coffee']
				]
			test:
				options:
					bare: true
					join: true
				files: 
					'.test/tests.js': ['.test/head.coffee', 'test/**/*.coffee']
			compile:
				options:
					bare: true # UglyHack: set a property to its default value to be able to call coffee:compile

		jade:
			index:
				files: 'compiled/index.html': 'src/index.jade'
			compile:
				files: 'compiled/templates.js': 'src/jade/**/*.jade'
				options:
					compileDebug: false
					client: true
					amd: true
					processName: (filename) -> filename.substring(9, filename.length-5)

		stylus:
			compile:
				options:
					paths: ['src/stylus/import']
					import: ['variables', 'functions']
				files:
					'compiled/css/project.css': [
						'src/stylus/**/*.styl'
						'!src/stylus/import/*.styl'
					]
		
		concat:
			css:
				src: [
					'compiled/lib/normalize-css/normalize.css'
					'compiled/css/project.css'
					'compiled/lib/faceted-search/compiled/css/main.css'
					'compiled/lib/hilib/compiled/**/*.css'
				]
				dest:
					'compiled/css/main.css'

		cssmin:
			stage:
				files:
					'stage/css/main.css': [
						'compiled/css/main.css'
					]

		# replace:
		# 	html:
		# 		src: 'compiled/index.html'
		# 		dest: 'stage/index.html'
		# 		replacements: [
		# 			from: '<script data-main="/js/main" src="/lib/requirejs/require.js"></script>'
		# 			to: '<script src="/js/main.js"></script>'
		# 		]

		requirejs:
			compile:
				options:
					baseUrl: "compiled/js"
					name: '../lib/almond/almond'
					include: 'main'
					# insertRequire: ['main']
					# exclude: ['backbone', 'jquery', 'underscore', 'helpers/fns'] # Managers and helpers should be excluded, but how?
					preserveLicenseComments: false
					out: "stage/js/main.js"
					optimize: 'none'
					paths:
						'jquery': '../lib/jquery/jquery.min'
						'underscore': '../lib/underscore-amd/underscore'
						'backbone': '../lib/backbone-amd/backbone'
						'text': '../lib/requirejs-text/text'
						'managers': '../lib/managers/compiled'
						'helpers': '../lib/helpers/compiled'
						'html': '../html'
					# wrap: true
					wrap:
						startFile: 'wrap.start.js'
						endFile: 'wrap.end.js'

		watch:
			options:
				livereload: true
			# 	nospawn: true
			coffeetest:
				files: 'test/**/*.coffee'
				tasks: ['coffee:test', 'shell:mocha-phantomjs']
			coffee:
				files: 'src/coffee/**/*.coffee'
				tasks: 'coffee:init'
			jade:
				files: ['src/index.jade', 'src/jade/**/*.jade']
				tasks: ['jade']
			stylus:
				files: ['src/stylus/**/*.styl']
				tasks: ['stylus', 'concat']
			css:
				files: ['compiled/lib/hilib/touch/css']
				tasks: ['concat:css']
			facetedsearch:
				files: ['compiled/lib/faceted-search/build']
				tasks: ['concat:css']



	#############
	### TASKS ###
	#############

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-stylus'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-requirejs'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-cssmin'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-shell'
	grunt.loadNpmTasks 'grunt-text-replace'

	grunt.registerTask('default', ['shell:mocha-phantomjs']);

	grunt.registerTask 'w', 'watch'

	# Compile src/ to compiled/ (empty dir, install deps, compile coffee, jade, stylus)
	grunt.registerTask 'c', 'compile'
	grunt.registerTask 'compile', [
		'shell:emptycompiled' # rm -rf compiled/
		'shell:bowerinstall' # Get dependencies first, cuz css needs to be included (and maybe images?)
		'coffee:init'
		'jade'
		'stylus:compile'
		'concat:css'
		# 'shell:symlink_compiled_images' # Symlink from images/ to compiled/images
		'createSymlinks:compiled'
	]

	grunt.registerTask 's', 'connect'

	grunt.registerTask 'server', 'connect'