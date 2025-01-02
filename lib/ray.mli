open Point3
open Vec3

module Ray : sig
  type t

  val create: Point3.t -> Vec3.t -> t
  val origin: t -> Point3.t
  val direction: t -> Vec3.t
  val at : t -> float -> Point3.t
end
[@@deriving sexp_of]
