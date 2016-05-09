'use strict'

# REQUIRES ######################################

Common = require './common.cjsx'
Stores = require './main_stores.coffee'

# STORES ########################################

#

# BALISES MAIN MENU COMPONENT ###################

CosBalisesMenuCpn = React.createClass
  add: (evt) ->
    #
    #
    console.log 'add btn'
    #
  create: (evt) ->
    #
    #
    console.log 'create btn'
    #
  delete: (evt) ->
    #
    #
    console.log 'delete btn'
    #
  render: ->
    #
    # TODO : get balises sets list
    #
    # TODO : hide delete if no selection
    #
    <span>
      <select></select>
      <span className='cos_spacer'>&nbsp;</span>
      <FaMinus onClick={@delete} className='iconBtn' />
      <FaPlus onClick={@create} className='iconBtn' />
      <FaDownload onClick={@add} className='iconBtn' />
    </span>
    #

# BALISES DIALOG COMPONENT ######################

CosBalisesDialogCpn = React.createClass
  render: ->
    #
    #
    <div>test</div>
    #

# BALS APP ######################################

window.Bals =
  run: ->
    #
    ReactDOM.render <CosBalisesMenuCpn />,document.getElementById 'bals_menu'
    #
    ReactDOM.render <Common.CosCloseBtn />,document.getElementById 'close'
