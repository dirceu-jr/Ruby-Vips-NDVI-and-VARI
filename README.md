# Ruby-Vips NDVI and VARI

Applies NDVI (Normalized Difference Vegetation Index) in NIR (near-infrared) orthophotos and VARI (Visible Atmospherically Resistant Index) Vegetation Index in RGB orthophotos using **[libvips](https://libvips.github.io/libvips/)** image processing library and their [Ruby binding](https://github.com/libvips/ruby-vips).

## What is NDVI and VARI?

Normalized Difference Vegetation Index and Visible Atmospherically Resistant Index are a simple graphical indicators that can be used to analyze remote sensing measurements, assessing whether or not the target being observed contains live green vegetation.

The NDVI is calculated from these individual measurements as follows: `NDVI = (NIR - Red) / (NIR + Red)`

And VARI = `(Green - Red) / (Green + Red - Blue)`

## What is libvips?



## Running it:

Install [libvips](https://libvips.github.io/libvips/install.html) and [Ruby](https://www.ruby-lang.org/en/). Then use Ruby's **gem** to install 'ruby-vips' and 'histogram' packages:

```
gem install histogram
gem install ruby-vips
```

OK? Run the program:

```
ruby ruby-vips-vari-ndvi.rb
```

_nir.png_ and _rgb.png_ orthophoto thumbnails will be processed and resulting _ndvi.png_ and _vari.png_ will be saved.

## Demo

### RGB → VARI
<img src="https://github.com/dirceup/pyvips-NDVI-and-VARI/blob/master/rgb.png" width="400"/> → <img src="https://github.com/dirceup/pyvips-NDVI-and-VARI/blob/master/vari.png" width="400"/>

### NIR → NDVI
<img src="https://github.com/dirceup/pyvips-NDVI-and-VARI/blob/master/nir.png" width="400"/> → <img src="https://github.com/dirceup/pyvips-NDVI-and-VARI/blob/master/ndvi.png" width="400"/>

## TODO

Explain each step from the algorithm with graphs and histograms...
