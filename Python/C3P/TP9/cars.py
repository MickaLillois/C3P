#Spec de voiture

from spec import specification, Attribute
import spec

@specification
class Engine(object):
    ...

@specification
class Vehicule(object):
    number_of_wheels = Attribute(int)
    engine = Attribute(Engine)

@specification
class Car(Vehicule):
    ...

header = spec.gen_class_header(Vehicule)
body = spec.gen_class_body(Vehicule)
print(header)
print(body)