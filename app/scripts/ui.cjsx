'use strict'

# SVG BUTTON ####################################

CosSvgBtn = React.createClass
  setIcon: (name) ->
    icon = null
    switch name
      when 'cross' then @iconCross()
      when 'miniplus' then @iconMiniPlus()
      when 'newdoc' then @iconNewDoc()
      when 'opendoc' then @iconOpenDoc()
      when 'plus' then @iconPlus()
  iconCross: -> <g transform='rotate(45)'>{@iconPlus()}</g>
  iconNewDoc: ->
    <g>
      <rect x="-7" y="-9" width="5" height="2" />
      <rect x="-8" y="-6" width="2" height="12" />
      <rect x="-7" y="7" width="10" height="2" />
      <rect x="3" y="3" width="2" height="3" />
      <g transform="translate(3,-4)">{@iconMiniPlus()}</g>
    </g>
  iconOpenDoc: ->
    #
    #
    <g>
      <path transform="translate(3,-3)" d="m-4 0 l8 0 l-4 -4 z" />
      <rect x="1" y="-2" width="4" height="3" />
      <rect x="-7" y="-7" width="4" height="2" />
      <rect x="" y="" width="" height="" />
      <rect x="-7" y="0" width="10" height="2" />
      <rect x="" y="" width="" height="" />
      <rect x="" y="" width="" height="" />
    </g>
    #
  iconMiniPlus: ->
    <g>
      <circle cx="0" cy="0" r="1" />
      <rect x="-1" y="-6" width="2" height="4" />
      <rect x="-1" y="2" width="2" height="4" />
      <rect x="-6" y="-1" width="4" height="2" />
      <rect x="2" y="-1" width="4" height="2" />
    </g>
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
    <svg onClick={@props.cb} className='svgBtn' title='test lab'><g transform={centering}>{icon}</g></svg>
