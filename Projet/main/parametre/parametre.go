package parametre

type Parametre struct{
	Indice int
	Entree string
}

func New(indice int, entree string) Parametre {  
    param := Parametre{indice, entree}
    return param
}