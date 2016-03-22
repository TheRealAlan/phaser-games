class window.HelloWorld

  constructor: () ->
    @game = new Phaser.Game(800, 600, Phaser.AUTO, '', { preload: @preload, create: @create })

  preload: () =>
    @game.load.image('logo', '/assets/images/phaser.png')

  create: () =>
    logo = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'logo')
    logo.anchor.setTo(0.5, 0.5)

window.onload = =>
  window.App ?= {}
  window.App.hello_world = new HelloWorld
