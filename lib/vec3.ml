open Core

module Vec3 = struct
  type t = {x: float; y: float; z: float} [@@deriving sexp_of]

  let create x y z = {x; y; z}

  let x a = a.x

  let y a = a.y

  let z a = a.z

  let add a b = {x = a.x +. b.x; y = a.y +. b.y; z = a.z +. b.z}

  let sub a b = {x = a.x -. b.x; y = a.y -. b.y; z = a.z -. b.z}

  let scale a k = {x = a.x *. k; y = a.y *. k; z = a.z *. k}

  let scale_inv a k = scale a (1. /. k)

  let neg a = scale a (-1.)

  let dot a b = a.x *. +. b.x +. a.y *. b.y +. a.z *. b.z

  let mag_squared a = dot a a

  let mag a = mag_squared a |> Float.sqrt

  let unit a = mag a |> scale_inv a

  let (+) = add

  let (-) = sub

  let ( * ) = scale

  let (/) = scale_inv

  let ( *. ) = dot
end
