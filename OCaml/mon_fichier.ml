(* Exercice 1 *)

    (* 1 *)
        (* Non c'est impossible *)
    (* 2 *)
    (* 3 *)
        (* 2.0 est un float *)
        (* 2,0 est un tuple *)
        (* 2;0 est une merde *)
        (* a est une unobound value *)
        (* 'a' est un char *)
        (* "a" est un string *)
        (* true est un bool *)
        (* () est un unit *)
        (* [] est un 'a list *)
        (* [1] est un int list *)
        (* [1,true] est une (int * bool) list *)
        (* [1;true] est une merde *)
    (* 4 *)
        (* int * float -> (1,2.0) *)
        (* (int, float) -> (1,2.0) *)
        (* string list -> ["shsh"] *)
        (* bool list * string ->  ([true],"test") *)
        (* ’a * int -> impossible *)
    (* 5 *)
        (* Les opérateurs && et || ne sont pas séquentiels (pas de shortcut) *)

(* Exercice 2 *)
    (* 1 *)
        (* let f x y = if x>y then x else y *)
    (* 2 *)
        (* let min x y = if x<y then x else y *)
        (* let g f a b c = f (f a b) c *)
    (* 3 *)
        (* let is_pair a = if a mod 2 = 0 then (string_of_int a) else "odd" *)
    (* 4 *)
        (* Non, on ne peut pas définir deux fois b *)
    (* 5 *)
        (* let b a = if a < 10 then "small" else "large" *)
    
(* Exercice 3 *)
    (* 1 *)
        (* let average a b c = (a + b + c) / 3 *)
    (* 2 *)
        (* let implies a b = if b = false && a = true then false else true *)
    (* 3 *)
        (* ('a,'b) -> 'a *)
    (* 4 *)
        (* fst : renvoie le premier élément du tuple *)
        (* snd : renvoie le deuxième élément du tuple *)
    (* 5 *)
        (* let inv (a, b) = (b, a) *)
        (* let inv c = (snd(c), fst(c)) *)
        (* let inv c = match c with
           | (a,b) -> (b,a) *)

(* Exercice 4 *)
    (* 1 *)
        (* let rec fib n = match n with
            | 0 -> 0
            | 1 -> 1
            | otherwise -> (fib (n-2)) + (fib (n-1)) *)
        
        (* let rec fib n = if n < 2 then n else (fib (n-2)) + (fib (n-1)) *) 

(* Exercice 5 *)
    (* 1 *)
        (* let rec pgcd m n = match m with
            | 0 -> n
            | otherwise -> if m > n then pgcd n m else pgcd (n mod m) m *)

(* Exercice 6 *)
    (* 1 *)
        (* let rec pair n = match n with
            | 0 -> true
            | otherwise -> if n > 0 then impair (n-1) else impair (n+1)   
            and impair n = match n with
            | 0 -> false
            | otherwise -> if n > 0 then pair (n-1) else pair (n+1) *)

(* Exercice 7 *)
    (* 1 *)
        (* let rec fact n = let rec auxiliaire resultat n = match n with
            | 0 -> resultat 
            | otherwise -> auxiliaire (n * resultat) (n-1)
            in auxiliaire 1 n *)

(* Exercice 8 *)
    (* 1 *)
        (* let rec fib n = let rec auxiliaire resultat n = match n with
            | 0 -> 0
            | 1 -> resultat
            | otherwise -> auxiliaire ((auxiliaire resultat (n-1)) + (auxiliaire resultat (n-2))) (n-1)
            in auxiliaire 1 n *)

    let fib n = let rec f n res =
        if n=0 then 0
        else if n=1 then res
        else f (n-1) ( (f (n-1) res) + (f (n-2) res))
    in f n 1;;