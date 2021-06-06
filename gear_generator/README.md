# Gear Generator

## Setup

1. Install Node
1. Install [`pngquant`](https://pngquant.org/) and add the binary to `PATH`
1. Run `yarn` inside `gear_generator`

## Generating images

1. Run `yarn start` inside `gear_generator`

## How it works

At a high level:

1. The program accepts an SVG with a single `path` element as input. The element
   must have an `id` of `shape`.
   - SVG input files are located in
     [`gear_generator/src/svg`](gear_generator/src/svg)
1. The SVG is loaded into a headless Chrome instance (using
   [Pupputeer](https://pptr.dev/))
1. The browser "scans" this path by walking through the path using the built-in
   [`getPointAtLength`](https://developer.mozilla.org/en-US/docs/Web/API/SVGGeometryElement/getPointAtLength)
   method, which returns the coordinates of the path at tooth-sized intervals.
1. Using the list of points found above, a "direction" is assigned to each point
   by comparing its location to its two neighbors. This direction is the angle
   in which the tooth will point.
1. This list of points and directions is used to generate a `GearDefinition`
   `.dart` file for each gear in [`lib/models/gears/`](lib/models/gears/).
1. The list of points is used to generate PNG images of each gear, complete with
   teeth (and optionally, holes).

### SVG input

While input SVG can be hand-written (or created in an application like
[Inkscape](https://inkscape.org/)), a series of small utilities (in
[`gear_generator/src/svg_automation`](gear_generator/src/svg_automation))
generates the majority of these input files.

#### Meta-data

The SVG files may optionally include some meta-data that changes how the final
gears are generated:

##### Entitlement

A gear can be associated with a [RevenueCat
entitlement](https://docs.revenuecat.com/v2.3/docs/entitlements) by including an
`<entitlement-id>` element like this:

```xml
<?xml version="1.0"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:inspiral="http://nathanfriend.io/inspiral">
  <desc xmlns:inspiral="http://nathanfriend.io/inspiral">
    <entitlement-id>
      io.nathanfriend.inspiral.trianglegears
    </entitlement-id>

  ...
```

In this example, this gear will require the
`io.nathanfriend.inspiral.trianglegears` entitlement in order to be selectable.

If no `<entitlement-id` element is found, the gear is considered to be part of
the free tier.

##### Package

Similar to above, a gear can be associated with a RevenueCat package:

```xml
<package-id>
  io.nathanfriend.inspiral.trianglegears
</package-id>
```

This mean this gear, if not yet purchased, will prompt the user to purchase the
`io.nathanfriend.inspiral.trianglegears` package when clicked.

In most (all?) cases, the `<entitlement-id>` and the `<package-id>` should have
the same value.

##### Gear order

The order in which the gears appear in the selector is determined by the
`<gear-order>` element:

```xml
<gear-order>
  40520
</gear-order>
```

##### Ring gears

To specify that the gear's teeth should appear on the _inside_ of the gear:

```xml
<inverted>
  true
</inverted>
```

##### Circular gears

To declare that a gear is perfectly round:

```xml
<is-round>
  true
</is-round>
```

Inspiral can make some assumptions for perfectly round gears
([for example](lib/util/calculate_rotation_count.dart)).

##### Holes

Holes can be specified by included `<circle>` elements inside a `<mask id="holes">` element. See the existing gear SVGs for examples of this.

##### Center point

The center point of the gear is specified using a `<circle id="center-point">`
element. If this element is omitted, the center of the (final) image is assumed
to be center of the gear.

##### Clip

By default, no clip is applied to image when rendered in the app, meaning the
_entire_ image responds to touch events, including the transparent areas. For
most gears, this isn't ideal, since it means the gears can accidentally be
dragged if the user touches a transparent part of the image.

To mitigate this, a gear can optionally specify a custom "clip" using either an
`<ellipse>` or `path` with an `id` of `clip`:

```xml
<ellipse id="clip"
         cx="16"
         cy="16"
         rx="16"
         ry="16" />
```

This will apply a clip to the image when rendering the image, which prevents the
image from responding to touch events outside the boundaries of the clip area.

When the clip is defined using an `<ellipse>`, the app creates the clip using a
[`ClipOval`](https://api.flutter.dev/flutter/widgets/ClipOval-class.html)
widget. When the clip is instead defined using a `<path>`, a
[`ClipPath`](https://api.flutter.dev/flutter/widgets/ClipPath-class.html) is
used instead.

When defining a clip using a `<path>`, note that the `d` attribute may _only_
contain the following commands:

- `M`
- `L`
- `Z`

Using unsupported commands will cause an error while running the generation
process.

It's important to test the clip in the app, since the clip shouldn't visually
alter the image in any way (it should only clip transparent portions of the
image). To visualize the clip, temporarily update `noFilterColorFilter` and
`fixedGearColorFilter` in `lib/widgets/color_filters.dart` like this:

```dart
// TEMP
final noFilterColorFilter = ColorFilter.mode(Colors.red, BlendMode.color);
final fixedGearColorFilter = ColorFilter.mode(Colors.blue, BlendMode.color);
```

## Troubleshooting/FAQ

**The rotating gear is rendered on the wrong side of the fixed gear!**

Reverse the direction of the path (using Inkscape).

**How do I control the number of teeth rendered on the gear?**

You can't :smile:. The number of teeth is automatically determined based on the
length of the path. To change the number of teeth, scale the path.

**How do I indicate if a gear should be a rotating gear or a fixed gear?**

Gears without holes are only available to be selected as fixed gears.

Gears with holes are only available to be selected as rotating gears.

**The gear teeth aren't lining up for large fixed gears.**

The maximum size for an image in Flutter is 8192x8192px (at least in the devices
I've test on. It's possible this is smaller or larger based on the device.) If
the image is larger than 8192, it seems that the image is scaled down to fit
within a 8192x8192 box.

Important note: this limit applies to the raw image size, not the logical pixel
size! For example, my Android phone renders at 3.0x, so this means the largest
image size in _logical_ pixels is 8192 / 3 ~= 2730px.

**Does my input SVG have to sit flush with the X/Y axes?**

No, any extra whitespace around the gear will be trimmed during the analysis
process.

**What if I want to regenerate SVG or Dart files, but don't need to re-render
PNGs?**

Use the `yarn start:fast` script instead of `yarn:start`. It skips some of the
optimization steps that `yarn:start` performs, so it's useful for development.
