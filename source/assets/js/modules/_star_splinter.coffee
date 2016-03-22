class window.StarSplinter

  constructor: () ->
    @game = new Phaser.Game(800, 600, Phaser.AUTO, '', { preload: @preload, create: @create, update: @update })

  preload: () =>
   

  create: () =>
    

  update: () =>
    

window.onload = =>
  window.App ?= {}
  window.App.hello_world = new StarSplinter
