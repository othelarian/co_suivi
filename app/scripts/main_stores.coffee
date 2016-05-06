'use strict'

# MAINSTORE #####################################

MainStore = Hoverboard
  init: ->
    name: '',path: '',current: 0,students: null,balises: null
  new: (state) ->
    #
    # TODO : change balises
    #
    name: 'nouveau suivi',path: '',current: 0,students: null,balises: null
  set: (state,name,path,current,students,balises) ->
    name: name,path: path,current: current,students: students,balises: balises
  setName: (state,name) ->
    state.name = name
    state
  #
  #selStudent
  #addStudent
  #remStudent
  #modStudent
  #
  #setBalises
  #
MainStore.init()

# STUDENT LIST STORE ############################

ListStudentStore = Hoverboard.compose MainStore, (state) -> state.students

# STUDENT STORE #################################

StudentStore = Hoverboard
  init: ->
    #
    #
    name: ''
    #
  set: (state,stud) ->
    #
    #
    name: stud.name
    #
StudentStore.init()

# EXPORTS #######################################

module.exports =
  ListStudentStore: ListStudentStore
  MainStore: MainStore
  StudentStore: StudentStore
