'use strict'

# GLOBAL VARIABLES ##############################

ipcRenderer = null

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
        Durée :
        <input className='arch_shortinp' maxLength='2' onChange={@upMins} value={@state.mins} />
        mins&nbsp;
        <input className='arch_shortinp' maxLength='2' onChange={@upSecs} value={@state.secs} />
        secs
      </p>
      <p className='arch_result'>{res} km/h</p>
    </div>

# APP ###########################################

CosApp =
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
        console.log 'we are on the main page !'
        #
        #
      when 'bals'
        #
        console.log 'we are on the balises page !'
        #
        #
      when 'calc' then ReactDOM.render <CosCalcCpt />,document.getElementById 'calc'
