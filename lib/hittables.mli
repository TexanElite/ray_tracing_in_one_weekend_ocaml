open Hit
open Ray

module Interval := Interval_lib.Interval

module Hittables : sig
  type hittable_callback = ray:Ray.t -> ray_t:Interval.Float.t -> Hit.t option
  type t

  val empty : t
  val add_exn: t -> hittable_callback -> t
  val hit_any : t -> ray:Ray.t -> ray_t:Interval.Float.t -> Hit.t option
end
