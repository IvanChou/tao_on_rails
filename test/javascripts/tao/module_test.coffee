{module, test} = QUnit

module 'TaoModule',

  before: ->
    class @ParentModule extends TaoModule
      @property 'x', default: 1
      @property 'y', default: 2

      _xChanged: ->
        @trigger 'xChanged'


    class @ChildModule extends @ParentModule
      @property 'x', default: 3
      @property 'z', default: 0

, ->

  test 'constructor options', (assert) ->
    parentInstance = new @ParentModule
      x: 3
    childInstance = new @ChildModule
      x: 4

    assert.equal parentInstance.x, 3
    assert.equal childInstance.x, 4

  test 'property inheritance', (assert) ->
    parentInstance = new @ParentModule()
    childInstance = new @ChildModule()

    assert.equal parentInstance.x, 1
    assert.equal parentInstance.y, 2
    assert.equal childInstance.x, 3
    assert.equal childInstance.y, 2
    assert.equal childInstance.z, 0

  test 'property changed hook', (assert) ->
    parentInstance = new @ParentModule()

    xChangedCount = 0
    parentInstance.on 'xChanged', ->
      xChangedCount++

    assert.equal parentInstance.x, 1
    assert.equal xChangedCount, 0

    parentInstance.x = 2
    assert.equal parentInstance.x, 2
    assert.equal xChangedCount, 1

    parentInstance.x = 3
    assert.equal parentInstance.x, 3
    assert.equal xChangedCount, 2

    parentInstance.x = 3
    assert.equal parentInstance.x, 3
    assert.equal xChangedCount, 2

  test 'self-increased module id', (assert) ->
    instance1 = new @ParentModule()
    id = instance1.id

    instance2 = new @ParentModule()
    assert.equal instance2.id, id + 1

    instance3 = new @ChildModule()
    assert.equal instance3.id, id + 2