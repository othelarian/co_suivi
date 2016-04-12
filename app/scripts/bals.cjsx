'use strict'

# REQUIRES ######################################

Common = require './common.cjsx'

# BALS APP ######################################

window.Bals =
  run: ->
    #
    #ReactDOM.render
    #
    ReactDOM.render <Common.CosCloseBtn />,document.getElementById 'close'
