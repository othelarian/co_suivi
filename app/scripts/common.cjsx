'use strict'

# CLOSE BUTTON COMPONENT ########################

CosCloseBtn = React.createClass
  close: -> window.close()
  render: ->
    <FaClose onClick={@close} className='iconBtn' />

# EXPORTS #######################################

module.exports =
  CosCloseBtn: CosCloseBtn
