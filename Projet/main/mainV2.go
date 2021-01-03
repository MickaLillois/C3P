package main

import (
	"main/parametre"
	"fmt"
	"strings"
	"os"
	"bufio"
	"log"
	"unicode"
    "golang.org/x/text/transform"
	"golang.org/x/text/unicode/norm"
	"flag"
	"strconv"
)

var m_oe_oo map[string] func(string) (string)  
var m_oe_to map[string] func(string) (string,string)
var m_te_oo map[string] func(string,string) (string)
var tabChaine []string
var splited bool


func main() {

	debugPtr := flag.Bool("debug",false,"Permet d'afficher le résultat ligne par ligne")
	flag.Parse()
	debugMode := *debugPtr

	var argnoflags []string

	for i := range os.Args{
		if (os.Args[i])[:1]!="-"{
			argnoflags = append(argnoflags,os.Args[i])
		}
	}

	if len(argnoflags) < 2 {
		fmt.Println("Vous n'avez pas donné d'argument")
	} else {
		chaineATraiter := argnoflags[1]
		tabChaine = append(tabChaine,chaineATraiter)
		tabChaine = append(tabChaine,"")

		if debugMode { fmt.Println("Chaine de départ : "+chaineATraiter) }

		m_oe_oo = map[string] func(string) (string) {
			"Upper": Upper,
			"Lower": Lower,
			"UpperFirst": UpperFirst,
			"Capitalize": Capitalize,
			"Normalize": Normalize,
			"Reverse": Reverse,
		}
		
		m_oe_to = map[string] func(string) (string,string) {
			"Copy": Copy,
			"Split": Split,
		}
		
		m_te_oo = map[string] func(string,string) (string) {
			"Concat": Concat,
		}

		fichier, err := os.Open("conf.txt")

		if err != nil {
			log.Fatalf("Impossible d'ouvrir le fichier : %s", err)
		}

		fileScanner := bufio.NewScanner(fichier)
		i:= 1

		for fileScanner.Scan() { 
			textScanned := fileScanner.Text()
			if _, ok := m_oe_to[textScanned]; ok{
				if splited {
					log.Fatalf("Le format du fichier de conf n'est pas valide : la chaine ne peut pas être coupée plusieurs fois.")
					break
				}
			}
			if _, ok := m_te_oo[textScanned]; ok{
				if !splited {
					log.Fatalf("Le format du fichier de conf n'est pas valide : impossible de concaténer : une seule chaine.")
					break
				}
			}
			if strings.Contains(textScanned, ",") {
				if !splited { 
					log.Fatalf("Le format du fichier de conf n'est pas valide : 2 fonctions pour une seule chaine.")
					break 
				}
				tableauInstructions := strings.Split(textScanned,",")
				for i, value := range tableauInstructions{
					functionChoose(parametre.New(i,value))
					//functionChoose(i,value)
				}
			} else {
				if tabChaine[1] != ""{
					functionChoose(parametre.New(1,textScanned))
					//functionChoose(1,textScanned)
				}
				functionChoose(parametre.New(0,textScanned))
				//functionChoose(0,textScanned)
			}
			if debugMode { fmt.Println("Ligne : "+strconv.Itoa(i)+" --> G:"+tabChaine[0] + " D:" +tabChaine[1]) }
			i = i+1
		}
		
		if !debugMode { fmt.Println("G:"+tabChaine[0] + " D:" +tabChaine[1]) }

		if err := fileScanner.Err(); err != nil {
			log.Fatalf("Impossible de lire le fichier: %s", err)
		}
		fichier.Close()
	}
}

func functionChoose(param parametre.Parametre){
	if _, ok := m_oe_oo[param.Entree]; ok{
		tabChaine[param.Indice] = execute_oe_oo(tabChaine[param.Indice],m_oe_oo[param.Entree])
	} else if _, ok := m_oe_to[param.Entree]; ok{
		str1, str2 := execute_oe_to(tabChaine[param.Indice],m_oe_to[param.Entree])
		tabChaine[0] = str1
		tabChaine[1] = str2
	} else if _, ok := m_te_oo[param.Entree]; ok{
		tabChaine[0] = execute_te_oo(tabChaine[0],tabChaine[1],m_te_oo[param.Entree])
		tabChaine[1] = ""
	}
}

// string -> string
func Upper(str string) (string){
	return strings.ToUpper(str)
}

func Lower(str string) (string){
	return strings.ToLower(str)
}

func UpperFirst(str string) (result string){
    result = Lower(str)
    result = Upper(result[:1]) + result[1:len(result)]
    return 
}

func Reverse(str string) (result string) { 
    for _, v := range str { 
        result = string(v) + result 
    } 
    return
}

func Normalize(str string) (string){
	t := transform.Chain(norm.NFD, transform.RemoveFunc(isMn), norm.NFC)
    result, _, _ := transform.String(t, str)
    return result
}

func Capitalize(str string) (string){
	return strings.Title(str)
}

func execute_oe_oo(a string, f func(string) string) (string) {
    return f(a)
}
func execute_oe_to(a string, f func(string) (string,string)) (string,string) {
    return f(a)
}
func execute_te_oo(a string, b string, f func(string,string) string) (string) {
    return f(a,b)
}

func isMn(r rune) (bool) {
    return unicode.Is(unicode.Mn, r) // Mn: nonspacing marks
}

// string -> string,string
func Copy(str string) (string,string){
	splited = true
	return str,str
}

func Split(str string) (string,string){
	splited = true
	return str[0:len(str)/2],str[len(str)/2:len(str)]
}

// string,string -> string
func Concat(str1 string,str2 string) (string){
	splited = false
	return str1 + str2
}

//te_to : func swap