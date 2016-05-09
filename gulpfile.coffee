'use strict'

# REQUIRES ######################################

changed = require 'gulp-changed'
child_p = require 'child_process'
concat = require 'gulp-concat'
del = require 'del'
elecpack = require 'electron-packager'
gulp = require 'gulp'
gutil = require 'gulp-util'
gplumber = require 'gulp-plumber'
gjade = require 'gulp-jade'
gstylus = require 'gulp-stylus'
lod = require 'lodash'
process = require 'process'
readl = require 'readline'
sq = require 'streamqueue'
srcmap = require 'gulp-sourcemaps'
through = require 'through2'
uglify = require 'gulp-uglify'
webpack = require 'webpack'
wps = require 'webpack-stream'

# CONFIGURATIONS ################################

config =
  name: 'co_suivi'
  app_path: 'app'
  build_path: 'build'
  release_path: 'release'
  electron_version: '0.37.5'
  rootfile: 'electric.js'
  src_path:
    electric: ['app/electric.coffee','app/comm.coffee']
    jade: 'app/**/*.jade'
    parse_package: './package.json'
    scripts: 'app/scripts/*'
    static: ''
    stylus: 'app/**/*.styl'
  build_args: ['static','parse_package','jade','stylus','scripts','electric']
  wp_scripts:
    entry:
      calc: './app/scripts/calc.cjsx'
      bals: './app/scripts/bals.cjsx'
      main: './app/scripts/main.cjsx'
      vendor: './app/scripts/vendor.coffee'
    output: filename: '[name].js'
    module:
      loaders: [
        {test: /\.coffee$/,loader: 'coffee-loader'}
        {test: /\.cjsx$/,loader: 'coffee-jsx-loader'}
      ]
    plugins: [new webpack.optimize.UglifyJsPlugin()]
  wp_electric:
    entry:
      comm: './app/comm.coffee'
      electric: './app/electric.coffee'
    target: 'electron'
    output: filename: '[name].js'
    module: loaders: [{test: /\.coffee$/,loader: 'coffee-loader'}]
    plugins: [new webpack.optimize.UglifyJsPlugin()]

# GLOBAL VARIABLES & FUNCTIONS ##################

prod = false
wp_watch = false
rl = null
pack_args = null
pack_lvl = null

clean_package = (opt) ->
  return through.obj (file,enc,cb) ->
    data = JSON.parse file.contents.toString 'utf-8'
    delete data.scripts
    delete data.devDependencies
    data.main = config.rootfile
    file.contents = new Buffer JSON.stringify data
    cb null,file

ask_pack = ->
  pack_args =
    dir: config.build_path
    name: config.name
    out: config.release_path
    version: config.electron_version
    overwrite: true
    #asar: true
  rl = readl.createInterface process.stdin,process.stdout,null
  console.log 'ELECTRON PACKAGE CREATION'
  rl.setPrompt 'target platform (linux,darwin,win32 or all) ?'
  rl.prompt()
  pack_lvl = 0
  rl.on 'line',(line) ->
    if pack_lvl is 0
      switch line.trim()
        when 'linux'
          pack_args.platform = 'linux'
          pack_lvl = 1
        when 'darwin'
          pack_args.platform = 'darwin'
          pack_args.arch = 'x64'
          pack_lvl = 2
        when 'win32'
          pack_args.platform = 'win32'
          pack_lvl = 1
        when 'all'
          pack_args.all = true
          pack_lvl = 2
        else console.log 'please enter one of the possibilities'
    else if pack_lvl is 1
      switch line.trim()
        when 'ia32'
          pack_args.arch = 'ia32'
          pack_lvl = 2
        when 'x64'
          pack_args.arch = 'x64'
          pack_lvl = 2
        when 'all'
          pack_args.arch = 'all'
          pack_lvl = 2
        else console.log 'please enter one of the possibilities'
    switch pack_lvl
      when 0
        rl.setPrompt 'target platform (linux,darwin,win32 or all) ? '
        rl.prompt()
      when 1
        rl.setPrompt 'target architecture (ia32,x64,all) ? '
        rl.prompt()
      when 2 then rl.close()
  rl.on 'close', ->
    console.log 'CREATE PACKAGE ...'
    elecpack pack_args,(err,appPath) -> if err then err else 'PACKAGE CREATION SUCCEED'

# DEFAULT TASK ##################################

gulp.task 'default', ->
  gutil.log ''
  gutil.log gutil.colors.blue '### GULPFILE for ARCHIBALD ###'
  gutil.log gutil.colors.blue '      ### FIRST INIT ###'
  gutil.log ''
  gutil.log 'Just after cloning the project, launch in console :'
  gutil.log '# npm install'
  gutil.log ''
  gutil.log 'The command \'gulp elec:vendor\' must be run every time the list of'
  gutil.log 'external libs changes.'
  gutil.log ''
  gutil.log gutil.colors.blue '      ### TASKS LIST ###'
  gutil.log ''
  gutil.log '   ',gutil.colors.underline 'gulp elec:clean'
  gutil.log 'Clean the build directory.'
  gutil.log ''
  gutil.log '   ',gutil.colors.underline 'gulp elec:launch'
  gutil.log 'Run the app from the build directory.'
  gutil.log ''
  gutil.log '   ',gutil.colors.underline 'gulp elec:build'
  gutil.log 'Build the project in dev mode. Vendor file is copied, but not generated.'
  gutil.log ''
  gutil.log '   ',gutil.colors.underline 'gulp elec:watch'
  gutil.log 'Build in dev mode, and then watch to rebuild every change.'
  gutil.log ''
  gutil.log '   ',gutil.colors.underline 'gulp elec:prod'
  gutil.log '.....'

# COMMON TASKS ##################################

gulp.task 'prod', -> prod = true
gulp.task 'clean', -> del config.build_path+'/**/*'
gulp.task 'build',config.build_args

gulp.task 'static', ->
  gulp
    .src config.src_path.static
    .pipe changed config.build_path
    .pipe gulp.dest config.build_path

gulp.task 'parse_package', ->
  gulp
    .src config.src_path.parse_package
    .pipe clean_package()
    .pipe gulp.dest config.build_path

gulp.task 'jade', ->
  gulp
    .src config.src_path.jade
    .pipe changed config.build_path
    .pipe if not prod then gplumber() else gutil.noop()
    .pipe gjade()
    .pipe gulp.dest config.build_path

gulp.task 'stylus', ->
  gulp
    .src config.src_path.stylus
    .pipe if not prod then gplumber() else gutil.noop()
    .pipe if not prod then srcmap.init() else gutil.noop()
    .pipe gstylus compress: true
    .pipe if not prod then srcmap.write() else gutil.noop()
    .pipe gulp.dest config.build_path

gulp.task 'scripts', ->
  if wp_watch then config.wp_scripts.watch = true
  gulp
    .src config.src_path.scripts
    .pipe if not prod then gplumber() else gutil.noop()
    .pipe wps config.wp_scripts
    .pipe gulp.dest config.build_path+'/scripts'

gulp.task 'electric', ->
  if wp_watch then config.wp_electric.watch = true
  gulp
    .src config.src_path.electric
    .pipe if not prod then gplumber() else gutil.noop()
    .pipe wps config.wp_electric
    .pipe gulp.dest config.build_path

# ELECTRON TASKS ################################

gulp.task 'elec:clean',['clean']

gulp.task 'elec:launch', ->
  process.chdir config.build_path
  child_p.execFileSync 'electron',[config.rootfile],stdio: [0,1,2]

gulp.task 'elec:build',['clean','build']

gulp.task 'elec:watch',['clean','build'], ->
  wp_watch = true
  for cmd of config.src_path then gulp.watch config.src_path[cmd],[cmd]

gulp.task 'elec:prod',['clean','prod','elec:build'], -> ask_pack()
