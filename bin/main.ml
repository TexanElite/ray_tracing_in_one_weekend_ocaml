open Core

open Ray_tracing_in_one_weekend_ocaml.Import

let ray_color r =
  let unit_direction = Ray.direction r |> Vec3.unit in
  let a = Vec3.y unit_direction |> Float.(+) 1.0 |> Float.( * ) 0.5 in
  Color.(scale (create 1. 1. 1.) (1.0 -. a) |> add (scale (create 0.5 0.7 1.0) a) )

let () =
  let image_width = 400 in
  let image_height = 25 * 9 in

  let focal_length = 1.0 in
  let viewport_height = 2.0 in
  let viewport_width = viewport_height *. ((float image_width) /. (float image_height)) in
  let camera_center = Point3.create 0. 0. 0. in

  let viewport_u = Vec3.create viewport_width 0. 0. in
  let viewport_v = Vec3.create 0. (0. -. viewport_height) 0. in

  let pixel_delta_u = Vec3.(viewport_u / (float image_width)) in
  let pixel_delta_v = Vec3.(viewport_v / (float image_height)) in

  let viewport_upper_left = Vec3.(camera_center - (create 0. 0. focal_length) - (scale_inv viewport_u 2.) - (scale_inv viewport_v 2.)) in
  let pixel00_loc = Vec3.(pixel_delta_u + pixel_delta_v |> Fn.flip scale_inv 2. |> add viewport_upper_left) in

  print_endline [%string "P3\n%{image_width#Int} %{image_height#Int}\n255"];

  for j = 0 to (image_height - 1) do
    for i = 0 to (image_width - 1) do
      let pixel_center = Point3.(pixel00_loc + (pixel_delta_u * (float i)) + (pixel_delta_v * (float j))) in
      let ray_direction = Vec3.sub pixel_center camera_center in
      let r = Ray.create pixel_center ray_direction in
      let color = ray_color r in
      Color.write_color color
    done
  done
