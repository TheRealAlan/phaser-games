Bullet = (game, key) ->
  Phaser.Sprite.call(@, game, 0, 0, key)
  @texture.baseTexture.scaleMode = PIXI.scaleModes.NEAREST
  @anchor.set 0.5
  @checkWorldBounds = true
  @outOfBoundsKill  = true
  @exists           = false
  @tracking         = false
  @scaleSpeed       = 0

Bullet.prototype = Object.create(Phaser.Sprite.prototype)
Bullet::constructor = Bullet

Bullet::fire = (x, y, angle, speed, gx, gy) ->
  gx = gx or 0
  gy = gy or 0
  @reset x, y
  @scale.set 1
  @game.physics.arcade.velocityFromAngle(angle, speed, @body.velocity)
  @angle = angle
  @body.gravity.set(gx, gy)

Bullet::update = ->
  if @tracking
    @rotation = Math.atan2(@body.velocity.y, @body.velocity.x)
  if @scaleSpeed > 0
    @scale.x += @scaleSpeed
    @scale.y += @scaleSpeed

Weapon = {}

# Single Bullet

Weapon.SingleBullet = (game) ->
  Phaser.Group.call(@, game, game.world, 'Single Bullet', false, true, Phaser.Physics.ARCADE)
  @nextFire    = 0
  @bulletSpeed = 600
  @fireRate    = 100

  for i in [0..64]
    @add new Bullet(game, 'bullet5'), true

  @

Weapon.SingleBullet.prototype = Object.create(Phaser.Group.prototype)
Weapon.SingleBullet::constructor = Weapon.SingleBullet

Weapon.SingleBullet::fire = (source) ->
  if @game.time.time < @nextFire
    return

  x = source.x + 10
  y = source.y + 10
  @getFirstExists(false).fire x, y, 0, @bulletSpeed, 0, 0
  @nextFire = @game.time.time + @fireRate

# Front and Back

Weapon.FrontAndBack = (game) ->
  Phaser.Group.call(@, game, game.world, 'Front And Back', false, true, Phaser.Physics.ARCADE)
  @nextFire = 0
  @bulletSpeed = 600
  @fireRate = 100

  for i in [0..64]
    @add new Bullet(game, 'bullet5'), true

  @

Weapon.FrontAndBack.prototype = Object.create(Phaser.Group.prototype)
Weapon.FrontAndBack::constructor = Weapon.FrontAndBack

Weapon.FrontAndBack::fire = (source) ->
  if @game.time.time < @nextFire
    return

  x = source.x + 10
  y = source.y + 10

  @getFirstExists(false).fire(x, y, 0, @bulletSpeed, 0, 0)
  @getFirstExists(false).fire(x, y, 180, @bulletSpeed, 0, 0)

  @nextFire = @game.time.time + @fireRate

# Three Way

Weapon.ThreeWay = (game) ->
  Phaser.Group.call(@, game, game.world, 'Three Way', false, true, Phaser.Physics.ARCADE)
  @nextFire    = 0
  @bulletSpeed = 600
  @fireRate    = 100

  for i in [0..96]
    @add new Bullet(game, 'bullet7'), true

  @

Weapon.ThreeWay.prototype = Object.create(Phaser.Group.prototype)
Weapon.ThreeWay::constructor = Weapon.ThreeWay

Weapon.ThreeWay::fire = (source) ->
  if @game.time.time < @nextFire
    return

  x = source.x + 10
  y = source.y + 10

  @getFirstExists(false).fire(x, y, 270, @bulletSpeed, 0, 0)
  @getFirstExists(false).fire(x, y, 0, @bulletSpeed, 0, 0)
  @getFirstExists(false).fire(x, y, 90, @bulletSpeed, 0, 0)

  @nextFire = @game.time.time + @fireRate

# 8 Way

Weapon.EightWay = (game) ->
  Phaser.Group.call(@, game, game.world, 'Eight Way', false, true, Phaser.Physics.ARCADE)
  @nextFire    = 0
  @bulletSpeed = 600
  @fireRate    = 100

  for i in [0..96]
    @add new Bullet(game, 'bullet5'), true

  @

Weapon.EightWay.prototype = Object.create(Phaser.Group.prototype)
Weapon.EightWay::constructor = Weapon.EightWay

Weapon.EightWay::fire = (source) ->
  if @game.time.time < @nextFire
    return

  x = source.x + 16
  y = source.y + 10

  @getFirstExists(false).fire(x, y, 0, @bulletSpeed, 0, 0)
  @getFirstExists(false).fire(x, y, 45, @bulletSpeed, 0, 0)
  @getFirstExists(false).fire(x, y, 90, @bulletSpeed, 0, 0)
  @getFirstExists(false).fire(x, y, 135, @bulletSpeed, 0, 0)
  @getFirstExists(false).fire(x, y, 180, @bulletSpeed, 0, 0)
  @getFirstExists(false).fire(x, y, 225, @bulletSpeed, 0, 0)
  @getFirstExists(false).fire(x, y, 270, @bulletSpeed, 0, 0)
  @getFirstExists(false).fire(x, y, 315, @bulletSpeed, 0, 0)
  @nextFire = @game.time.time + @fireRate

# Scattershot

Weapon.ScatterShot = (game) ->
  Phaser.Group.call(@, game, game.world, 'Scatter Shot', false, true, Phaser.Physics.ARCADE)
  @nextFire    = 0
  @bulletSpeed = 600
  @fireRate    = 40

  for i in [0..32]
    @add new Bullet(game, 'bullet5'), true

  @

Weapon.ScatterShot.prototype = Object.create(Phaser.Group.prototype)
Weapon.ScatterShot::constructor = Weapon.ScatterShot

Weapon.ScatterShot::fire = (source) ->
  if @game.time.time < @nextFire
    return

  x = source.x + 16
  y = source.y + source.height / 2 + @game.rnd.between(-10, 10)

  @getFirstExists(false).fire(x, y, 0, @bulletSpeed, 0, 0)
  @nextFire = @game.time.time + @fireRate

# Beam

Weapon.Beam = (game) ->
  Phaser.Group.call(@, game, game.world, 'Beam', false, true, Phaser.Physics.ARCADE)

  @nextFire    = 0
  @bulletSpeed = 1000
  @fireRate    = 45

  for i in [0..64]
    @add new Bullet(game, 'bullet11'), true

  @

Weapon.Beam.prototype = Object.create(Phaser.Group.prototype)
Weapon.Beam::constructor = Weapon.Beam

Weapon.Beam::fire = (source) ->
  if @game.time.time < @nextFire
    return

  x = source.x + 40
  y = source.y + 10

  @getFirstExists(false).fire(x, y, 0, @bulletSpeed, 0, 0)
  @nextFire = @game.time.time + @fireRate

# Split Shot

Weapon.SplitShot = (game) ->
  Phaser.Group.call(@, game, game.world, 'Split Shot', false, true, Phaser.Physics.ARCADE)

  @nextFire    = 0
  @bulletSpeed = 700
  @fireRate    = 40

  for i in [0..64]
    @add new Bullet(game, 'bullet8'), true

  @

Weapon.SplitShot.prototype = Object.create(Phaser.Group.prototype)
Weapon.SplitShot::constructor = Weapon.SplitShot

Weapon.SplitShot::fire = (source) ->
  if @game.time.time < @nextFire
    return

  x = source.x + 20
  y = source.y + 10

  @getFirstExists(false).fire(x, y, 0, @bulletSpeed, 0, -500)
  @getFirstExists(false).fire(x, y, 0, @bulletSpeed, 0, 0)
  @getFirstExists(false).fire(x, y, 0, @bulletSpeed, 0, 500)

  @nextFire = @game.time.time + @fireRate

# Pattern

Weapon.Pattern = (game) ->
  Phaser.Group.call(@, game, game.world, 'Pattern', false, true, Phaser.Physics.ARCADE)

  @nextFire    = 0
  @bulletSpeed = 600
  @fireRate    = 40

  @pattern = Phaser.ArrayUtils.numberArrayStep(-800, 800, 200)
  @pattern = @pattern.concat(Phaser.ArrayUtils.numberArrayStep(800, -800, -200))
  @patternIndex = 0

  for i in [0..64]
    @add new Bullet(game, 'bullet4'), true

  @

Weapon.Pattern.prototype = Object.create(Phaser.Group.prototype)
Weapon.Pattern::constructor = Weapon.Pattern

Weapon.Pattern::fire = (source) ->
  if @game.time.time < @nextFire
    return

  x = source.x + 20
  y = source.y + 10

  @getFirstExists(false).fire(x, y, 0, @bulletSpeed, 0, @pattern[@patternIndex])
  @patternIndex++

  if @patternIndex == @pattern.length
    @patternIndex = 0

  @nextFire = @game.time.time + @fireRate

# Rockets

Weapon.Rockets = (game) ->
  Phaser.Group.call(@, game, game.world, 'Rockets', false, true, Phaser.Physics.ARCADE)

  @nextFire    = 0
  @bulletSpeed = 400
  @fireRate    = 250

  for i in [0..32]
    @add new Bullet(game, 'bullet10'), true

  @setAll 'tracking', true
  @

Weapon.Rockets.prototype = Object.create(Phaser.Group.prototype)
Weapon.Rockets::constructor = Weapon.Rockets

Weapon.Rockets::fire = (source) ->
  if @game.time.time < @nextFire
    return

  x = source.x + 10
  y = source.y + 10

  @getFirstExists(false).fire(x, y, 0, @bulletSpeed, 0, -700)
  @getFirstExists(false).fire(x, y, 0, @bulletSpeed, 0, 700)

  @nextFire = @game.time.time + @fireRate

# Scale

Weapon.ScaleBullet = (game) ->
  Phaser.Group.call(@, game, game.world, 'Scale Bullet', false, true, Phaser.Physics.ARCADE)

  @nextFire    = 0
  @bulletSpeed = 800
  @fireRate    = 100

  for i in [0..32]
    @add new Bullet(game, 'bullet9'), true

  @setAll 'scaleSpeed', 0.05
  @

Weapon.ScaleBullet.prototype = Object.create(Phaser.Group.prototype)
Weapon.ScaleBullet::constructor = Weapon.ScaleBullet

Weapon.ScaleBullet::fire = (source) ->
  if @game.time.time < @nextFire
    return

  x = source.x + 10
  y = source.y + 10

  @getFirstExists(false).fire(x, y, 0, @bulletSpeed, 0, 0)
  @nextFire = @game.time.time + @fireRate

# Combo 1

Weapon.Combo1 = (game) ->
  @name = 'Combo One'
  @weapon1 = new (Weapon.SingleBullet)(game)
  @weapon2 = new (Weapon.Rockets)(game)

Weapon.Combo1::reset = ->
  @weapon1.visible = false
  @weapon1.callAll('reset', null, 0, 0)
  @weapon1.setAll('exists', false)
  @weapon2.visible = false
  @weapon2.callAll('reset', null, 0, 0)
  @weapon2.setAll('exists', false)

Weapon.Combo1::fire = (source) ->
  @weapon1.fire source
  @weapon2.fire source

# Combo 2

Weapon.Combo2 = (game) ->
  @name = 'Combo Two'
  @weapon1 = new (Weapon.Pattern)(game)
  @weapon2 = new (Weapon.ThreeWay)(game)
  @weapon3 = new (Weapon.Rockets)(game)

Weapon.Combo2::reset = ->
  @weapon1.visible = false
  @weapon1.callAll('reset', null, 0, 0)
  @weapon1.setAll('exists', false)
  @weapon2.visible = false
  @weapon2.callAll('reset', null, 0, 0)
  @weapon2.setAll('exists', false)
  @weapon3.visible = false
  @weapon3.callAll('reset', null, 0, 0)
  @weapon3.setAll('exists', false)

Weapon.Combo2::fire = (source) ->
  @weapon1.fire(source)
  @weapon2.fire(source)
  @weapon3.fire(source)


class window.BulletPool

  constructor: () ->
    @game = new Phaser.Game(640, 400, Phaser.AUTO, 'game', { preload: @preload, create: @create, update: @update } )

    @speed          = 300
    @current_weapon = 0
    @weapons        = []

  preload: () =>
    @game.load.image('background', '/assets/images/bulletpool/back.png')
    @game.load.image('foreground', '/assets/images/bulletpool/fore.png')
    @game.load.image('player', '/assets/images/bulletpool/ship.png')
    @game.load.bitmapFont('shmupfont', '/assets/images/bulletpool/shmupfont.png', '/assets/images/bulletpool/shmupfont.xml')

    for i in [1..11]
      @game.load.image("bullet#{i}", "/assets/images/bulletpool/bullet#{i}.png")

  create: () =>
    @game.renderer.renderSession.roundPixels = true
    @game.physics.startSystem(Phaser.Physics.ARCADE)

    @background = @game.add.tileSprite(0, 0, @game.width, @game.height, 'background')
    @background.autoScroll(-40, 0)

    @foreground = @game.add.tileSprite(0, 0, @game.width, @game.height, 'foreground')
    @foreground.autoScroll(-60, 0)

    @weapons.push(new Weapon.SingleBullet(@game))
    @weapons.push(new Weapon.FrontAndBack(@game))
    @weapons.push(new Weapon.ThreeWay(@game))
    @weapons.push(new Weapon.EightWay(@game))
    @weapons.push(new Weapon.ScatterShot(@game))
    @weapons.push(new Weapon.Beam(@game))
    @weapons.push(new Weapon.SplitShot(@game))
    @weapons.push(new Weapon.Pattern(@game))
    @weapons.push(new Weapon.Rockets(@game))
    @weapons.push(new Weapon.ScaleBullet(@game))
    @weapons.push(new Weapon.Combo1(@game))
    @weapons.push(new Weapon.Combo2(@game))

    @current_weapon = 0

    for i in @weapons.length
      @weapons[i].visible = false

    @player = @game.add.sprite(64, 200, 'player')

    @game.physics.arcade.enable(@player)
    @player.body.collideWorldBounds = true

    @weapon_name = @game.add.bitmapText(8, 364, 'shmupfont', "ENTER = Next Weapon", 24);

    # controls
    @cursors = @game.input.keyboard.createCursorKeys()

    @game.input.gamepad.start()
    @pad1 = @game.input.gamepad.pad1

  update: () =>
    @player.body.velocity.set(0)

    # controls
    if @cursors.left.isDown || @pad1.isDown(Phaser.Gamepad.XBOX360_DPAD_LEFT) || @pad1.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) < -0.1
      console.log "left"
      @player.body.velocity.x = -@speed
    else if @cursors.right.isDown || @pad1.isDown(Phaser.Gamepad.XBOX360_DPAD_RIGHT) || @pad1.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) > 0.1
      console.log "right"
      @player.body.velocity.x = @speed

    if @cursors.up.isDown || @pad1.isDown(Phaser.Gamepad.XBOX360_DPAD_UP) || @pad1.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_Y) < -0.1
      console.log "up"
      @player.body.velocity.y = -@speed
    else if @cursors.down.isDown || @pad1.isDown(Phaser.Gamepad.XBOX360_DPAD_DOWN) || @pad1.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_Y) > 0.1
      console.log "down"
      @player.body.velocity.y = @speed

    if @game.input.keyboard.isDown(Phaser.Keyboard.SPACEBAR) || @pad1.justPressed(Phaser.Gamepad.XBOX360_A)
      console.log "fire"
      @weapons[@current_weapon].fire(@player)

    if @game.input.keyboard.isDown(Phaser.Keyboard.ENTER) || @pad1.justPressed(Phaser.Gamepad.XBOX360_B)
      console.log "change weapon"
      @next_weapon()

  next_weapon: =>

    if @current_weapon > 9
      # @weapons[@current_weapon].reset()
    else
      @weapons[@current_weapon].visible = false
      @weapons[@current_weapon].callAll('reset', null, 0, 0)
      @weapons[@current_weapon].setAll('exists', false)

    @current_weapon++

    if @current_weapon == @weapons.length
      @current_weapon = 0

    @weapons[@current_weapon].visible = true
    @weapon_name.text = @weapons[@current_weapon].name

window.onload = =>
  window.App ?= {}
  window.App.bulletpool = new BulletPool
