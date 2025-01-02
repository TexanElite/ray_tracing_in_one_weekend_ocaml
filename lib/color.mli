open Vec3

module Color : sig
  include module type of Vec3

  val r : t -> float
  val g : t -> float
  val b : t -> float

  val write_color : t -> unit
end
