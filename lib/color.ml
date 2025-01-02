open Core

open Vec3

module Color = struct
  include Vec3

  let r a = x a

  let g a = y a

  let b a = z a

  let write_color a =
    let ir = int_of_float (Float.( * ) 255.999 (r a)) in
    let ig = int_of_float (Float.( * ) 255.999 (g a)) in
    let ib = int_of_float (Float.( * ) 255.999 (b a)) in

      print_endline [%string "%{ir#Int} %{ig#Int} %{ib#Int}"]
end
