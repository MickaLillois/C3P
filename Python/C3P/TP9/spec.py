#Fonctions relatives au marquage de classes et à la génération spec.py

def specification(cls):
    cls.specification = True
    return cls

class Attribute(object):
    def __init__(self, t):
        self.type = t

def gen_class_header(cls):
    mystr = ""
    for base in cls.__bases__:
        mystr = mystr + base.__name__
    header = "class "+cls.__name__+"("+mystr+"):"
    return header

def gen_class_body(cls):
    from inspect import isfunction
    myList = []
    myDict = cls.__dict__
    for key, val in myDict.items():
        if not isfunction(val) and not key.startswith('__') and key != "specification":
            myList.append(key)
    myBody = "    pass"
    if len(myList) != 0:
        separator = "=None, "
        myBody = "\tdef __init__(self, "+ separator.join(myList)+"=None)\n"
        for item in myList:
            myBody = myBody + "\t\tself."+item+" = " + item + "\n"
        for item in myList:
            myBody = myBody + "\t@property\n"
            myBody = myBody + "\tdef "+ item +"(self):\n"
            myBody = myBody + "\t\treturn self."+item+"\n"
            myBody = myBody + "\n"
            myBody = myBody + "\t@"+item+".setter\n"
            myBody = myBody + "\tdef "+ item +"(self,value):\n"
            myBody = myBody + "\t\tassert value is None or isinstance(value,"+myDict[item].type.__name__+")\n"
            myBody = myBody + "\t\tself._"+item+" = value\n"
    return myBody