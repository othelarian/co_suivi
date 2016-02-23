'use strict'

# REQUIRES ######################################

electron = require 'electron'
fs = require 'fs'

app = electron.app
BrowWin = electron.BrowserWindow
ipcMain = electron.ipcMain
dialog = electron.dialog

# GLOBAL CLASS ##################################

class ElecWin
  constructor: (@path,@width = 800,@height = 600) ->
    @pointer = null
  open: (dev = false) ->
    @pointer = new BrowWin width: @width,height: @height
    @pointer.loadURL 'file://'+__dirname+@path
    @pointer.on 'closed',(evt) => @pointer = null
    @pointer.setMenuBarVisibility false
    @pointer.setMinimumSize @width,@height
    if dev then @pointer.webContents.openDevTools()

# GLOBAL VARIABLES ##############################

reg_cos = new RegExp '[\.]cos$'
reg_bals = new RegExp '[\.]balcos$'

mainWin = new ElecWin '/wins/main.html',600,300
calcWin = new ElecWin '/wins/calc.html'
balsWin = new ElecWin '/wins/bals.html'

# IPC COMMS #####################################

ipcMain.on 'async',(evt,args) ->
  #
  #evt.sender.send 'msg'
  #
  switch args.cmd
    when 'open'
      switch args.name
        when 'calc' then calcWin.open true
        when 'bals' then balsWin.open true
    #
  #

ipcMain.on 'sync',(evt,args) ->
  #
  switch args.cmd
    when 'open'
      #
      on
      #
  #

# APP ###########################################

app.on 'window-all-closed', -> app.quit()

app.on 'ready', ->
  mainWin.open true
  mainWin.pointer.on 'close', ->
    if calcWin.pointer? then calcWin.pointer.close()
    if balsWin.pointer? then balsWin.pointer.close()
