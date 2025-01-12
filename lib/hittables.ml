open Core
open Hit
open Ray

module Hittables = struct
  type hittable_callback = ray:Ray.t -> ray_tmin:float -> ray_tmax:float -> Hit.t option
  type t = {
    entries: (int, hittable_callback, Int.comparator_witness) Map.t;
    counter: int
  } [@@deriving fields ~getters]

  let empty = {entries = Int.Map.empty; counter = 0}

  let add_exn t data = let entries = Map.add_exn (entries t) ~key:(counter t) ~data in
    {entries; counter = counter t + 1}

  let hit_any t ~ray ~ray_tmin ~ray_tmax =
    entries t |> Map.data |>
    List.fold ~f:(
      fun (closest, best_hit) hittable_callback -> match hittable_callback ~ray ~ray_tmin ~ray_tmax:closest with
        | Some hit -> (Hit.distance hit), Some hit
        | None -> (closest, best_hit)
    ) ~init:(ray_tmax, None) |> snd
end
