(* transforme un string en liste de char *) 

type opes = 
      Push of int    
    | MULT
    | ADD
    | SUB
    | DIV
    | MOD
    | INV (* à confirmer *)
    | ASCII
    | NO_OP
    ;;


let explode str = 
    let rec str_aux str n = match n with
        | 0 -> []  
        | n -> (str_aux str (n-1)) @ [(String.get str (n-1))]
        in str_aux str (String.length str);;
    

let decode a = match a with
    | char when a >= '0' && a <= '9' -> Push(int_of_string (Char.escaped a))
    | '*' -> MULT
    | '+' -> ADD
    | '-' -> SUB
    | '/' -> DIV
    | '%' -> MOD
    | '!' -> INV (* à confirmer *)
    | ',' -> ASCII
    | _ -> NO_OP;;

let rec transform list = match list with
    | [] -> []
    | a::r -> [decode a] @ (transform r) ;;


let rec list_cleaner list = match list with
    | [] -> []
    | a::r when a = NO_OP -> []
    | a::r -> [a] @ (list_cleaner r) ;;

let code_to_tokenized str = str |> explode |> transform |> list_cleaner;;

let magistack_inter prog = 
    let rec magistack_inter lu a_lire stack = match a_lire, stack with
        | Push(a)::r,stack -> magistack_inter (lu @ [Push(a)]) r (a::stack)   
        | MULT::r,a::b::tail -> magistack_inter (lu @ [MULT]) r ((a*b)::tail)
        | ADD::r,a::b::tail -> magistack_inter (lu @ [ADD]) r ((a+b)::tail)
        | SUB::r,a::b::tail -> magistack_inter (lu @ [SUB]) r ((b-a)::tail)
        | DIV::r,a::b::tail -> magistack_inter (lu @ [DIV]) r ((b/a)::tail)
        | MOD::r,a::b::tail -> magistack_inter (lu @ [MOD]) r ((b mod a)::tail)
        | INV::r,a::tail -> magistack_inter (lu @ [INV]) r ((1/a)::tail) (* à confirmer *)
        | ASCII::r,a::tail -> (print_char (char_of_int a)) magistack_inter (lu @ [INV]) r ((1/a)::tail)
        | [],stack -> stack
        | _,_ -> failwith "Erreur non codé"
        in magistack_inter [] prog [];;

let magistack str = magistack_inter (code_to_tokenized str);;


(* magistack "89*";; ==> ['8','9','*'] ==> [Value(8),Value(9),MULT,NO_OP]
type ops = Value of int | MULT | NO_OP
String.get str i;;
String.length str

Stack
Programme compilé

magistack_inter [] (list.hd prog) (list.tl prog) []
[] Value(8) [Value(9);MULT] []
[Value(8)] Value(9) [MULT] [8] *)