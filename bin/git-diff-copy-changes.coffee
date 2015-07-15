#!/usr/bin/env coffee

require 'shelljs/global'

minimist = require 'minimist'

{ dest, cwd } = minimist process.argv.slice 2

{ dirname, basename, resolve, sep } = require 'path'

cwd ?= process.cwd()

dest ?= (new Date()).getTime().toString()

cd cwd

cmd = "git diff --name-only"

out = exec(cmd, silent: true).output

console.log out

process.exit 0

files = [
	'Gruntfile.js',
	'assets/sprite/refresh.svg',
	'css/touchrevamp/components/app-update.less',
	'css/touchrevamp/components/style.less',
	'css/tvg4/legacy/components/app-update.less',
	'css/tvg4/legacy/components/style.less',
	'js/bootstrap.js',
	'js/modules/AppUpdate/appUpdateMod.js',
	'js/modules/AppUpdate/controllers/appUpdateCtrl.js',
	'js/modules/AppUpdate/directives/app-update-directive.js',
	'js/modules/AppUpdate/providers/appUpdateSvc.js',
	'js/modules/AppUpdate/templates/app-update.html',
	'package.json',
	'tests/unit-tests/main.js',
	'js/bootstrap.js',
	'tests/unit-tests/main.js'
]

files.map (f) ->

	f = resolve f

	file = f.split(cwd + sep).pop()

	file = resolve dest, file

	folder = dirname file

	if not test "-e", folder then mkdir "-p", folder

	cp f, file
