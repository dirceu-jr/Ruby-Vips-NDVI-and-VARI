# Ruby-Vips NDVI and VARI

Apply NDVI (Normalized Difference Vegetation Index) and VARI (Visible Atmospherically Resistant Index) Vegeration Index in NIR (near-infrared) and RGB orthophotos using **[libvips](https://libvips.github.io/libvips/)** image processing library and their [Ruby binding](https://github.com/libvips/ruby-vips).

It is a simplified version of my project [tiled-vegetation-indices](https://github.com/dirceup/tiled-vegetation-indices/) where I demonstrate how to compute statistics from orthophoto thumbnails then use it to apply the index to [map tiles](https://en.wikipedia.org/wiki/Tiled_web_map).

## Running it:

Install [libvips](https://libvips.github.io/libvips/install.html) and [Ruby](https://www.ruby-lang.org/en/). Then use Ruby's **gem** to install 'ruby-vips' and 'histogram' packages:

```
gem install histogram
gem install ruby-vips
```

Okay? Call the program:

```
ruby ruby-vips-vari-ndvi.rb
```

_nir.png_ and _rgb.png_ orthophoto thumbnails will be processed and resulting _ndvi.png_ and _vari.png_ will be saved.