open Hit
open Point3
open Ray
open Vec3

module type Make_arg = sig
  type t

  module Interval := Interval_lib.Interval

  val outward_normal : t -> point:Point3.t -> Vec3.t
  val ray_intersection : t -> ray:Ray.t -> ray_t:Interval.Float.t -> float option
end

module type S = sig
  type t

  module Interval := Interval_lib.Interval

  val hit : t -> ray:Ray.t -> ray_t:Interval.Float.t -> Hit.t option
end

module type Hittable = sig
  module type S = S
  module Make (T : Make_arg) : S with type t := T.t
end
