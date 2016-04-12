'use strict'

# REQUIRES ######################################

Common = require './common.cjsx'

# GLOBAL VARIABLES ##############################

ipcRenderer = null
btns = width: 22,height: 22

# COS MAIN MENU COMPONENT #######################

CosMainMenuCpn = React.createClass
  newDoc: (evt) ->
    #
    #
    console.log 'create'
    #
  openDoc: (evt) ->
    #
    #
    console.log 'open'
    #
  saveDoc: (evt) ->
    #
    #
    console.log 'save'
    #
  importCsv: (evt) ->
    #
    #
    console.log 'import csv'
    #
  exportCsv: (evt) ->
    #
    #
    console.log 'export csv'
    #
  openCalc: (evt) -> CosApp.ipcAsync cmd: 'open',name: 'calc'
  openBals: (evt) -> CosApp.ipcAsync cmd: 'open',name: 'bals'
  render: ->
    <span>
      <FaFile onClick={@newDoc} className='iconBtn' />
      <FaFolderOpen onClick={@openDoc} className='iconBtn' />
      <FaFloppyO onClick={@saveDoc} className='iconBtn' />
      <span className='cos_spacer'>&nbsp;</span>
      <FaDownload onClick={@importCsv} className='iconBtn' />
      <FaUpload onClick={@exportCsv} className='iconBtn' />
      <span className='cos_spacer'>&nbsp;</span>
      <MdAvTimer onClick={@openCalc} className='iconBtn' />
      <FaCompass onClick={@openBals} className='iconBtn' />
    </span>

# COS SUB MENU COMPONENT ########################

CosSubMenuCpn = React.createClass
  render: ->
    #
    #
    <div>test 123</div>
    #

# COS LIST STUDS COMPONENT ######################

# COS FORM STUD COMPONENT #######################

# APP ###########################################

window.CosApp =
  closeWin: -> window.close()
  ipcAsync: (evt) -> window.ipcRenderer.send 'async',evt
  ipcAsyncReply: (evt,args) ->
    #
    console.log evt
    console.log args
    #
  ipcSync: (msg) ->
    #
    console.log msg
    #
    #
  run: ->
    #
    #
    ReactDOM.render <CosMainMenuCpn />,document.getElementById 'main_menu'
    #
    ReactDOM.render <Common.CosCloseBtn />,document.getElementById 'close'
