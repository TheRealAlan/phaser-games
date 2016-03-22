class window.Breakout

  constructor: ->
    @_init()

  _init: ->
    @canvas = document.getElementById("canvas")
    @ctx    = @canvas.getContext("2d")

    @score = 0
    @lives = 3

    @x = @canvas.width / 2
    @y = @canvas.height - 30

    @dx = 2
    @dy = -2

    @ball_radius = 10

    @paddle_width  = 75
    @paddle_height = 10

    @brick_row_count    = 3
    @brick_column_count = 5
    @brick_width        = 75
    @brick_height       = 20
    @brick_padding      = 10
    @brick_offset_top   = 30
    @brick_offset_left  = 30
    @bricks             = []

    column = 0
    while column < @brick_column_count
      @bricks[column] = []
      row = 0
      while row < @brick_row_count
        @bricks[column][row] = {
          x: 0,
          y: 0,
          status: 1
        }
        row++
      column++

    @left_pressed  = false
    @right_pressed = false

    @paddle_x = (@canvas.width - @paddle_width) / 2

    document.addEventListener("keydown", @_key_down_handler, false)
    document.addEventListener("keyup", @_key_up_handler, false)
    document.addEventListener("mousemove", @_mouse_move_handler, false)

    @_draw()

  _key_down_handler: (ev) =>
    if ev.keyCode == 39
      @right_pressed = true
    else if ev.keyCode == 37
      @left_pressed = true

  _key_up_handler: (ev) =>
    if ev.keyCode == 39
      @right_pressed = false
    else if ev.keyCode == 37
      @left_pressed = false

  _mouse_move_handler: (ev) =>
    relative_x = ev.clientX - @canvas.offsetLeft

    if relative_x > 0 && relative_x < @canvas.width
      @paddle_x = relative_x - @paddle_width / 2

  _draw_bricks: =>
    column = 0
    while column < @brick_column_count
      row = 0
      while row < @brick_row_count
        if @bricks[column][row].status == 1
          brick_x = (column * (@brick_width + @brick_padding)) + @brick_offset_left
          brick_y = (row * (@brick_height + @brick_padding)) + @brick_offset_top
          @bricks[column][row].x = brick_x
          @bricks[column][row].y = brick_y
          @ctx.beginPath()
          @ctx.rect(brick_x, brick_y, @brick_width, @brick_height)
          @ctx.fillStyle = "#0095DD"
          @ctx.fill()
          @ctx.closePath()
        row++
      column++

  _draw_ball: =>
    @ctx.beginPath()
    @ctx.arc(@x, @y, @ball_radius, 0, Math.PI*2)
    @ctx.fillStyle = "#0095DD"
    @ctx.fill()
    @ctx.closePath()

  _draw_paddle: =>
    @ctx.beginPath()
    @ctx.rect(@paddle_x, @canvas.height - @paddle_height, @paddle_width, @paddle_height)
    @ctx.fillStyle = "#0095DD"
    @ctx.fill()
    @ctx.closePath()

  _collision_detection: =>
    column = 0
    while column < @brick_column_count
      row = 0
      while row < @brick_row_count
        brick = @bricks[column][row]
        if brick.status == 1
          if @x > brick.x && @x < brick.x + @brick_width && @y > brick.y && @y < brick.y + @brick_height
            @dy = -@dy
            brick.status = 0
            @score++
            if @score == @brick_row_count * @brick_column_count
              alert("YOU WIN, CONGRATULATIONS!")
              document.location.reload()
        row++
      column++

  _draw_score: =>
    @ctx.font = "16px Arial"
    @ctx.fillStyle = "#0095DD"
    @ctx.fillText("Score: #{@score}", 8, 20)

  _draw_lives: =>
    @ctx.font = "16px Arial"
    @ctx.fillStyle = "#0095DD"
    @ctx.fillText("Lives: #{@lives}", @canvas.width - 65, 20)

  _draw: =>
    @ctx.clearRect(0, 0, @canvas.width, @canvas.height)
    @_draw_bricks()
    @_draw_ball()
    @_draw_paddle()
    @_draw_score()
    @_draw_lives()
    @_collision_detection()

    # left / right collision detection
    if @x + @dx > @canvas.width - @ball_radius || @x + @dx < @ball_radius
      @dx = -@dx

    # top / bottom collision detection
    if @y + @dy < @ball_radius
      @dy = -@dy
    else if @y + @dy > @canvas.height - @ball_radius
      if @x > @paddle_x && @x < @paddle_x + @paddle_width
        @dy = -@dy
      else
        @lives--

        if @lives == 0
          alert("GAME OVER")
          document.location.reload()
        else
          @x = @canvas.width / 2
          @y = @canvas.height - 30
          @dx = 2
          @dy = -2
          @paddle_x = (@canvas.width - @paddle_width) / 2

    # handle paddle
    if @right_pressed && @paddle_x < @canvas.width - @paddle_width
      @paddle_x += 7
    else if @left_pressed && @paddle_x > 0
      @paddle_x -= 7

    @x += @dx
    @y += @dy

    requestAnimationFrame(@_draw)
