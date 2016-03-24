class window.Metroid

  constructor: () ->
    @game = new Phaser.Game(800, 600, Phaser.AUTO, '', { preload: @preload, create: @create, update: @update })

    @player_speed  = 200
    @gravity       = 300
    @jump_velocity = 250

    @direction = "right"

  preload: () =>
   @game.load.spritesheet('dude', '/assets/images/metroid/dude.png', 40, 40)
   @game.load.image('ground', '/assets/images/phaser_tut_02/platform.png')

   @game.load.audio('brinstar', '/assets/music/brinstar.mp3')

  create: () =>
    # level stuff
    @game.physics.startSystem(Phaser.Physics.ARCADE)

    @platforms = @game.add.group()
    @platforms.enableBody = true

    ground = @platforms.create(0, @game.world.height - 64, 'ground')
    ground.scale.setTo(2, 2)
    ground.body.immovable = true

    # player stuff
    @player = @game.add.sprite(40, @game.world.height - 150, 'dude')
    @player.scale.setTo(2, 2)

    @game.physics.arcade.enable(@player)

    @player.body.gravity.y = @gravity
    @player.body.collideWorldBounds = true

    @player.animations.add('left', [2, 1, 0], 10, true)
    @player.animations.add('right', [5, 6, 7], 10, true)

    # music
    @music = @game.add.audio('brinstar')
    @music.play()

    # keyboard
    @cursors = @game.input.keyboard.createCursorKeys()

    # controller
    @game.input.gamepad.start()
    @pad1 = @game.input.gamepad.pad1

    # fullscreen
    this.game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
    this.game.scale.fullScreenScaleMode = Phaser.ScaleManager.SHOW_ALL
    # this.game.scale.pageAlignHorizontally = true
    # this.game.scale.pageAlignVertically   = true

  update: () =>
    @game.physics.arcade.collide(@player, @platforms)

    @player.body.velocity.x = 0

    # handle movement
    if @cursors.left.isDown || @pad1.isDown(Phaser.Gamepad.XBOX360_DPAD_LEFT) || @pad1.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) < -0.1
      @player.body.velocity.x = -@player_speed
      @direction = "left"

      if @player.body.touching.down
        @player.animations.play('left')

    else if @cursors.right.isDown || @pad1.isDown(Phaser.Gamepad.XBOX360_DPAD_RIGHT) || @pad1.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) > 0.1
      @player.body.velocity.x = @player_speed
      @direction = "right"

      if @player.body.touching.down
        @player.animations.play('right')

    else
      @player.animations.stop()

      if @player.body.touching.down
        if @direction == "left"
          @player.frame = 3
        else if @direction == "right"
          @player.frame = 4

    if @game.input.keyboard.isDown(Phaser.Keyboard.SPACEBAR) || @pad1.justPressed(Phaser.Gamepad.XBOX360_A) && @player.body.touching.down
      @player.body.velocity.y = -@jump_velocity

      @player.animations.stop()

      if @direction == "left"
        @player.frame = 8
      else if @direction == "right"
        @player.frame = 9

  gofull: =>
    if @game.scale.isFullScreen
      @game.scale.stopFullScreen()
    else
      @game.scale.startFullScreen(false)

window.onload = ->
  window.App ?= {}
  window.App.metroid = new Metroid

  fullscreen_btn = document.getElementById("fullscreen_btn")

  fullscreen_btn.addEventListener "click", (ev) =>
    ev.preventDefault()
    window.App.metroid.gofull()
