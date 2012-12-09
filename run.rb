print = ->(to_print) {
  STDOUT << to_print
}

print.("hello world!\n")

line = ->(recurse) {
  ->(print) {
     print.("\n")
     recurse.(print)
  }
}

recurse_it = ->(cb) {
  ->(recurse) {
    ->(x){line.(recurse).(cb).(x)}
  }
}

buffered1 = ->(cb) {
  ->(x) {
    cb.(x)
    ->(x) {
      recurse_it.(cb).(buffered1).(x)
    }
  }
}

buffered2 = ->(cb) {
  ->(x){
    cb.(x)
    ->(x){
       cb.(x)
       ->(x) {
         recurse_it.(cb).(buffered2).(x)
       }
    }
  }
}

buffered3 = ->(cb) {
  ->(x){
    cb.(x)
    ->(x){
      cb.(x)
      ->(x){
        cb.(x)
        line.(buffered3).(cb)
      }
    }
  }
}

buffered4 = ->(cb) {
  ->(x){
    cb.(x)
    ->(x){
      cb.(x)
      ->(x){
        cb.(x)
        ->(x){
          cb.(x)
          line.(buffered4).(cb)
        }
      }
    }
  }
}

buffered = buffered1.(print)
evolve = ->(board) {
  board.(buffered)
}

board = ->(fun) {
  fun.('.')
    .('x')
    .('x')
    .('.')
    .('.')
    .('x')
    .('.')
    .('.')
    .('.')
    .('.')
    .('x')
    .('.')
    .('x')
    .('.')
    .('x')
    .('.')
    .('.')
    .('.')
    .('x')
    .('.')
    .('.')
    .('x')
    .('.')
    .('.')
    .('.')
    .('x')
    .('.')
    .('.')
    .('x')
    .('.')
  #fun.('x') # let's get a newline after this
  # fun.('.')
}

evolve.(board)
