(* Exercice 1 *)
    (* 1 *)
        let rec integers n = match n with 
            | 0 -> [n]
            | otherwise -> (integers (n-1)) @ [n];;
    (* 2 *)
        let integers2 n = List.rev (let rec interne n = match n with 
                                                | 0 -> [n]
                                                | otherwise -> n :: (interne (n-1))
                                                in interne n);;
    (* 3 *)
        let integers3 = 
            let rec integers3' cpt n = match cpt with 
                | cpt when cpt = (n+1) -> []
                | cpt -> cpt :: (integers3' (cpt+1) n)
                in integers3' 0;;

        let rec integers3' cpt n = match cpt with 
                | cpt when cpt = (n+1) -> []
                | cpt -> cpt :: (integers3' (cpt+1) n);;
        
(* Exercice 2 *)
    (* 1 *)
        let size l = 
            let rec size_aux l acc = match l with
                | [] -> acc
                | a::r -> size_aux r (acc+1)
                in size_aux l 0;;
    (* 2 *)
        let three_or_more l = if (size l) >= 3 then true else false;;
    (* 3 *)
        let last l = List.hd (List.rev l);;
    (* 4 *)
        let rec sum l = match l with
            | [] -> 0
            | a::r -> a + (sum r) ;;
    (* 5 *)
        let rec find e l = match l with
            | [] -> false
            | a::r -> if a = e then true else find e r;;
    (* 6 *)
        let nth n l =
            let rec nth_aux cpt n l = match cpt,l with
                | _, [] -> failwith "erreur"
                | cpt,a::r when cpt = (n-1) -> a 
                | cpt,a::r -> nth_aux (cpt+1) n r
                in nth_aux 0 n l;;
    (* 7 *)
        let rec is_increasing l = match l with
                | [] -> true
                | [a] -> true
                | a::r -> if a <= (List.hd r) then is_increasing r else false;;

(* Exercice 3 *)
    (* 1 *)
        let rec list_copy l = match l with
            | [] -> []
            | [a] -> [a]
            | a::r -> a::(list_copy r);;
    (* 2 *)
        let rec reverse l = match l with
            | [] -> []
            | [a] -> [a]
            | a::r -> (reverse r)@[a];;
    (* 3 *)
        let rec flatten_list l = match l with
            | [] -> []
            | [a] -> [a]
            | a::r -> a @ (flatten_list r);;
    (* 4 *)
        let rec without_duplicates l = match l with
            | [] -> []
            | [a] -> [a]
            | a::r -> if a = (List.hd r) then without_duplicates r else a :: (without_duplicates r);;
    (* 5 *)
        let records l = match l with 
            | [] -> []
            | [a] -> [a]
            | a::r -> a :: (let rec records_aux l max = match l,max with
                | [],_ -> []
                | a::r,max -> if a > max then a :: (records_aux r a) else records_aux r max
                in records_aux l (List.hd l));;
        
        let rec records_aux l max = match l,max with
                | [],_ -> []
                | a::r,max -> if a > max then a :: (records_aux r a) else records_aux r max;;

(* Exercice 4 *)
    (* 1 *)
        let rec filter f l = match l with
            | [] -> []
            | a::r -> if f a then a :: filter f r else filter f r;; 
            (* filter (function x -> x < 5) [1;2;6;7];; *)
    (* 2 *)
        let rec collect f l = match l with
            | [] -> []
            | a::r -> (f a) :: collect f r;;
            (* collect (function x -> x * 2) [1;2;6;7];; *)
    (* 3 *)
        let rec reject f l = match l with 
            | [] -> []
            | a::r -> if f a then reject f r else a :: (reject f r);;
            (* reject (function x -> (x mod 2 = 0)) [1;2;6;7];; *)
    (* 4 *)
        let rec includes e l = match l with
            | [] -> false
            | a::r -> if a = e then true else includes e r;;
    (* 5 *)
        let rec including l1 l2 = match l1,l2 with
            | [],[] -> true
            | [],_ -> true
            | _,[] -> false
            | a::r,l2 -> if includes a l2 then including r l2 else false;;
    (* 6 *)
        let rec excludes e l = not (includes e l);;
    (* 7 *)
        let rec excluding l1 l2 = not (including l1 l2);;
    (* 8 *)
        let zip l1 l2 = if (size l1) != (size l2) 
                            then failwith "Liste de tailles différentes" 
                            else (let rec zip_aux l1 l2 = match l1,l2 with
                                        | [],[] -> []
                                        | a1::r1,a2::r2 -> (a1,a2) :: (zip_aux r1 r2)
                                        in zip_aux l1 l2);;

(* Exercice 5 *)
    (* 1 *)
        (* 'a -> ('a -> 'b) -> 'b = <fun> *)
    (* 2 *)
        (* On a donné la liste en paramètre de la fonction partielle par l'opérateur |> *)
    (* 3 *)
        let pair_cleaner l = l |> without_duplicates |> reverse |> filter (function x -> (x mod 2) = 0);;
    (* 4 *)
        let nb_odd_numbers l = l |> filter (function x -> (x mod 2) = 1) |> size;;
    (* 5 *)
        let rec string_of_int_list l = match l with
            | [] -> ""
            | a::r -> String.concat (string_of_int a) ["";(string_of_int_list r)];; 
    (* 6 *)
        let odd_squared l = l |> filter (function x -> (x mod 2) = 1) |> collect (function x -> x * x);;