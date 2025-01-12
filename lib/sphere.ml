open Core
open Point3
open Ray
open Vec3

module Sphere = struct
  module T = struct
    type t = {center: Point3.t ; radius: float}
    [@@deriving fields ~getters]

    let create ~center ~radius = {center; radius}

    let outward_normal hittable ~point = Point3.((point - center hittable) / radius hittable)

    let ray_intersection hittable ~ray ~ray_tmin ~ray_tmax =
      let oc = Point3.(center hittable - Ray.origin ray) in
      let a = Vec3.mag_squared (Ray.direction ray) in
      let h = Vec3.dot (Ray.direction ray) oc in
      let c = Vec3.mag_squared oc -. radius hittable *. radius hittable in
      let discriminant = h *. h -. a *. c in
      if Float.(discriminant < 0.) then None
      else
        let large_root = (h +. sqrt discriminant) /. a in
        let small_root = (h -. sqrt discriminant) /. a in
        match large_root, small_root with
        | _, root when Float.(root > ray_tmin && root < ray_tmax) -> Some root
        | root, _ when Float.(root > ray_tmin && root < ray_tmax) -> Some root
        | _, _ -> None
  end
  include T
  include Hittable.Make (T)
end
