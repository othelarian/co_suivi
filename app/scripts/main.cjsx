'use strict'

# GLOBAL VARIABLES ##############################

ipcRenderer = null
btns = width: 24,height: 24

# COS BALS MENU COMPONENT #######################

# COS MAIN MENU COMPONENT #######################

CosMainMenuCpt = React.createClass
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
  render: ->
    <span>
      <CosSvgBtn cb={@newDoc} icon='newdoc' />
      <CosSvgBtn cb={@openDoc} icon='opendoc' />
      <CosSvgBtn cb={@saveDoc} icon='savedoc' />
      <span className="cos_spacer">&nbsp;</span>
      <CosSvgBtn cb={@newDoc} icon='newdoc' />
      I |
      E |
      CALC |
      BALS
    </span>
    #

# COS SUB MENU COMPONENT ########################

CosSubMenuCpt = React.createClass
  render: ->
    #
    #
    <div>test 123</div>
    #

# COS LIST STUDS COMPONENT ######################

# COS FORM STUD COMPONENT #######################

# COS CALC COMPONENT ############################

CosCalcCpt = React.createClass
  getInitialState: -> mins: 0,secs: 0,dist: 0
  upDist: (evt) ->
    if not isNaN(evt.target.value) and evt.target.value[0] != '-'
      @setState dist: evt.target.value
  upMins: (evt) ->
    if not isNaN(evt.target.value) and evt.target.value[0] != '-'
      @setState mins: evt.target.value
  upSecs: (evt) ->
    if not isNaN(evt.target.value) and evt.target.value[0] != '-'
      @setState secs: evt.target.value
  checkRes: ->
    res = 0
    if @state.dist is '' and parseFloat(@state.dist) > 0 then res
    else
      duree = if @state.mins is '' then 0 else parseFloat(@state.mins)*60
      duree += if @state.secs is '' then 0 else parseFloat(@state.secs)
      res = if duree > 0 then (parseFloat(@state.dist)/duree)*3.6 else 0
      Math.round(res*10)/10
  render: ->
    res = @checkRes()
    res = if res <= 0 then '--,-' else res
    <div>
      <p>Distance (en m) : <input onChange={@upDist} value={@state.dist} /></p>
      <p>
        Durée :&nbsp;
        <input className='cos_shortinp' maxLength='2' onChange={@upMins} value={@state.mins} />
        mins&nbsp;
        <input className='cos_shortinp' maxLength='2' onChange={@upSecs} value={@state.secs} />
        secs
      </p>
      <p className='cos_result'>{res} km/h</p>
    </div>

# APP ###########################################

CosApp =
  closeWin: -> window.close()
  ipcAsync: (evt) -> ipcRenderer.send 'async',evt
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
  run: (page) ->
    ipcRenderer = require('electron').ipcRenderer
    switch page
      when 'main'
        #
        # TODO : encapsulation dans le store
        #
        ReactDOM.render <CosMainMenuCpt />,document.getElementById 'main_menu'
        #
        #
      when 'bals'
        #
        console.log 'we are on the balises page !'
        #
        #
      when 'calc' then ReactDOM.render <CosCalcCpt />,document.getElementById 'calc'
    ReactDOM.render <CosSvgBtn cb={CosApp.closeWin} icon="cross" />,document.getElementById 'close'
