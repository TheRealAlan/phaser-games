class window.Game

  constructor: () ->
    @game = new Phaser.Game(800, 600, Phaser.AUTO, '', { preload: @preload, create: @create, update: @update })

  preload: () =>
    @game.load.image('sky', '/assets/images/sky.png')
    @game.load.image('ground', '/assets/images/platform.png')
    @game.load.image('star', '/assets/images/star.png')
    @game.load.spritesheet('dude', '/assets/images/dude.png', 32, 48)

  create: () =>
    # level stuff
    @game.physics.startSystem(Phaser.Physics.ARCADE)
    @game.add.sprite(0, 0, 'sky')

    @platforms = @game.add.group()
    @platforms.enableBody = true

    ground = @platforms.create(0, @game.world.height - 64, 'ground')
    ground.scale.setTo(2, 2)
    ground.body.immovable = true

    ledge = @platforms.create(400, 400, 'ground')
    ledge.body.immovable = true

    ledge = @platforms.create(-150, 250, 'ground')
    ledge.body.immovable = true

    # player stuff
    @player = @game.add.sprite(32, @game.world.height - 150, 'dude')
    @game.physics.arcade.enable(@player)

    @player.body.bounce.y = 0.2
    @player.body.gravity.y = 300
    @player.body.collideWorldBounds = true

    @player.animations.add('left', [0, 1, 2, 3], 10, true)
    @player.animations.add('right', [5, 6, 7, 8], 10, true)

    # stars
    @stars = @game.add.group()
    @stars.enableBody = true

    for i in [1..12]
      star = @stars.create(i * 70, 0, 'star')
      star.body.gravity.y = 6
      star.body.bounce.y = 0.7 * Math.random() * 0.2

    # controls
    @cursors = @game.input.keyboard.createCursorKeys()

    # score
    @score = 0
    @score_text = @game.add.text(16, 16, "Score: #{@score}", { fontSize: "32px", fill: "#000" })

  update: () =>
    # add collisiont detection to platforms and player
    @game.physics.arcade.collide(@player, @platforms)

    # player default
    @player.body.velocity.x = 0

    # handle movement
    if @cursors.left.isDown
      @player.body.velocity.x = -150
      @player.animations.play('left')
    else if @cursors.right.isDown
      @player.body.velocity.x = 150
      @player.animations.play('right')
    else
      @player.animations.stop()
      @player.frame = 4

    # handle jumping
    if @cursors.up.isDown && @player.body.touching.down
      @player.body.velocity.y = -350

    # stars
    @game.physics.arcade.collide(@stars, @platforms)
    @game.physics.arcade.overlap(@player, @stars, @_collect_star, null, @)

  _collect_star: (@player, star) =>
    star.kill()

    # update score
    @score += 10
    @score_text.text = "Score: #{@score}"

window.onload = =>
  window.App ?= {}
  window.App.hello_world = new Game
