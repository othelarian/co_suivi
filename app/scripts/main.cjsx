'use strict'

# REQUIRES ######################################

Common = require './common.cjsx'
Stores = require './main_stores.coffee'

# STORES ########################################

window.MainStore = Stores.MainStore
window.ListStudentStore = Stores.ListStudentStore
window.StudentStore = Stores.StudentStore

# COS MAIN MENU COMPONENT #######################

CosMainMenuCpn = React.createClass
  exportCsv: (evt) ->
    #
    #
    console.log 'export csv'
    #
  importCsv: (evt) ->
    #
    if MainStore().name != ''
      #
      #
      console.log 'save before import !'
      #
    #
    console.log 'import csv'
    #
  newDoc: (evt) ->
    if MainStore().name != ''
      #
      #
      console.log 'save before create !'
      #
    #
    MainStore.new()
    #
    #
  openBals: (evt) -> comm.ipcAsync cmd: 'open',name: 'bals'
  openCalc: (evt) -> comm.ipcAsync cmd: 'open',name: 'calc'
  openDoc: (evt) ->
    if MainStore().name != ''
      #
      # TODO : save before going anywhere !
      #
      console.log "open one"
      #
      #
    #
    # TODO : use ipc to open 'open file' dialog
    #
    res = comm.ipcSync cmd: 'open'
    #
    console.log res
    #
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
  saveDoc: (evt) ->
    #
    # TODO : use ipc to communicate
    #
    console.log 'save'
    #

# COS SUB MENU COMPONENT ########################

CosSubMenuCpn = React.createClass
  render: ->
    #
    #console.log @props
    #
    #
    menu_show = if @props.name != '' then 'block' else 'none'
    #
    <div style={{display:menu_show}}>
      Sub menu
    </div>
    #

# COS LIST STUDS COMPONENT ######################

CosStudListCpn = React.createClass
  render: ->
    #
    console.log @props
    #
    <div className='cos_studlist'>test</div>
    #

# COS FORM STUD COMPONENT #######################

CosDetailsCpn = React.createClass
  render: ->
    #
    #
    <div className='cos_stud'>test</div>
    #

# APP ###########################################

window.CosApp =
  run: ->
    MainStore.getState (state) ->
      ReactDOM.render <CosSubMenuCpn {...state} />,document.getElementById 'sub_menu'
    ListStudentStore.getState (state) ->
      ReactDOM.render <CosStudListCpn {...state} />,document.getElementById 'list_studs'
    StudentStore.getState (state) ->
      ReactDOM.render <CosDetailsCpn {...state} />,document.getElementById 'form_stud'
    ReactDOM.render <CosMainMenuCpn />,document.getElementById 'main_menu'
    ReactDOM.render <Common.CosCloseBtn />,document.getElementById 'close'
