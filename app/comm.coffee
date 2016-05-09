'use strict'

window.ipcRenderer = require('electron').ipcRenderer

window.comm =
  ipcAsync: (evt) -> window.ipcRenderer.send 'async',evt
  ipcAsyncReply: (evt,args) ->
    #
    console.log evt
    console.log args
    #
  ipcSync: (msg) -> window.ipcRenderer.sendSync 'sync',msg
