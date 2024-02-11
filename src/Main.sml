open TM
val T = ([I, I, I], I, nil);
val r = Eval.eval P T;
val s = Dynamic.pp {T = T, r = r};