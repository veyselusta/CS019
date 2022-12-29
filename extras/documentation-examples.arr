use context essentials2021
include tables
  
namelist :: List<Number, String> = [list: 1, "Selma"]

tuplee :: { Number; String;} = {1; "String";}


lambda = lam({shadow x; shadow y}): x + y end


fun f(v, w, x, y, z): v + w + x + y + z  end

call-f-with-123 = lam(y, z): f(1, 2, 3, y, z) end
call-f-with-123v2 = f(_, 2, 3, _, _) # same as the fun expression above

pluss = lam(x, y, z): x + y + z end
sluss = lam(z): pluss(1, 2, z) end
cluss = pluss(1, 2, _)(3)



tuples = { pluss(1, 2, _)(3); 5}

obj = {a: 5, method b(x, y): x + y end}
m = obj.b


  o = {x : "original-x", y: "original-y"}
  o2 = o.{x : "new-x", z : "new-z"}


tt = load-table: name :: String, email :: String end