use context essentials2021
# Calculator 

data Calc:
  | Constant(x :: Number)
  | Multiply(x :: Calc, y :: Calc)
  | Negate(x :: Calc, y :: Calc)
  | Add(x :: Calc, y :: Calc)
end

fun calc(operation):
  cases(Calc) operation:
    | Constant(x) => x
    | Multiply(x, y) => calc(x) * calc(y)
    | Add(x, y) => calc(x) + calc(y)
    | Negate(x, y) => calc(x) - calc(y)
  end
where:
  calc(Add(Add(Constant(2), Constant(4)), Multiply(Constant(4), Constant(7)))) is 34
end


# Fake fucntion binding

data FakeFun:
  | Exp(exp :: Calc)
  | Bind(body :: FakeFun)
end

fun eval(funbinding):
  cases(FakeFun) funbinding:
    | Exp(exp) => calc(exp)
    | Bind(body) => lam(): eval(body) end
  end
where:
  block:
    app = eval(Bind(Exp(Add(Constant(1), Constant(2)))))
    app()
  end
    is 3
end
