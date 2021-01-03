class Expr():
    def evaluate(self):
        pass

class Value(Expr):
    def __init__(self, val):
        self.val = val

    def __repr__(self):
        return 'Val(' + str(self.val) + ')'

    def evaluate(self):
        return self.val

class Binop(Expr):
    def __init__(self, op, left, right):
        self.op = op
        self.left = left
        self.right = right

    def __repr__(self):
        return f"{self.op}({self.left}, {self.right})"

    def evaluate(self,context):
        eval_left = self.left.evaluate(context)
        eval_right = self.right.evaluate(context)
        function = context(self.op)
        return function(eval_left,eval_right)
        

class Unop(Expr):
    def __init__(self, op, expr):
        self.op = op
        self.expr = expr

    def __repr__(self):
        return f"{self.op} {self.expr}"

    def evaluate(self,context):
        eval_expr = self.expr.evaluate(context)
        function=context(self.op)
        return function(0,eval_expr)


def add(x,y):
    return x + y
def sub(x,y):
    return x - y
def mult(x,y):
    return x * y
def div(x,y):
    return x / y
def mod(x,y):
    return x % y
    
context_operateurs={
    '+': add,
    '-': sub,
    '*': mult,
    '/': div,
    '%':mod,
}

# 1 + 3 + - 4
expr1 = Binop("+", 
            left=Value(1),
            right=Binop("+",
                left=Value(3),
                right=Unop(".", Value(4))))