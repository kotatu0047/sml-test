structure Eval =
struct
  open TM
  fun Hd nil = B          (* 先頭要素を取り出す *)
    | Hd (h :: _) = h
  fun Tl nil = nil        (* 先頭要素を取り除く *)
    | Tl (_ :: tl) = tl
  fun Cons (B, nil) = nil (* リストの先頭に追加する *)
    | Cons (h,t) = h::t

  fun moveL (LList, h, RList) =               (* テープの左へ移動する *)
      (Tl LList, Hd LList, Cons (h, RList))   (* テープの左側の先頭から一つ取ってヘッドに書き込む。以前のヘッドにあった要素は右側の先頭に追加する *)
  fun moveR (LList, h, RList) =               (* テープの右へ移動する *)
      (Cons (h, LList), Hd RList, Tl RList)   (* テープの右側の先頭から一つ取ってヘッドに書き込む。以前のヘッドにあった要素は左側の先頭に追加する *)
  fun move L tape = moveL tape  (* 第1引数の型によってmoveLかmoveRを呼び出すのか分岐する *)
    | move R tape = moveR tape

  (* fun print (q, (LList, h, RList)) =
      Dynamic.pp
      {state=q,
       tape = (List.rev LList, h, RList)} *)

  (* プログラム(delta),初期状態(q),初期テープ((LList, h, RList))を受け取り、状態遷移を可能な限り繰り返す *)       
  fun exec delta (q, tape as (LList, h, RList)) =
       case List.find (fn (x,y) => x = (q, h)) delta of
         NONE => (LList, h, RList)
       | SOME (x, (q', s, d)) => 
         exec delta (q', move d (LList, s, RList))

  fun eval (state, delta) tape = exec delta (state,tape)
end
