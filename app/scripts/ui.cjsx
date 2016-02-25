'use strict'

# SVG BUTTON ####################################

CosSvgBtn = React.createClass
  setIcon: (name) ->
    icon = null
    switch name
      when 'cross' then @iconCross()
      when 'plus' then @iconPlus()
  iconCross: -> <g transform='rotate(45)'>{@iconPlus()}</g>
  iconPlus: ->
    <g>
      <circle cx="0" cy="0" r="2" />
      <rect x="-2" y="-11" width="4" height="8" />
      <rect x="-2" y="3" width="4" height="8" />
      <rect x="-11" y="-2" width="8" height="4" />
      <rect x="3" y="-2" width="8" height="4" />
    </g>
  render: ->
    icon = @setIcon @props.icon
    centering = "translate(#{btns.width/2},#{btns.height/2})"
    <svg onClick={@props.cb} className="svgBtn"><g transform={centering}>{icon}</g></svg>
