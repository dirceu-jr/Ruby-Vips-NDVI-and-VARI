# install with 'gem install histogram'
require 'histogram/array'

# install with 'gem install ruby-vips'
require 'ruby-vips'

# find min/max and histogram
def result_histogram(result)
  flat_result = result.to_a.flatten
  flat_result.reject!(&:nan?)
  flat_result.histogram(256)[1]
end

# Remaps value (that has an expected range of in_low to in_high) into a target range of to_low to to_high
def math_map_value(value, in_low, in_high, to_low, to_high)
  to_low + (value - in_low) * (to_high - to_low) / (in_high - in_low)
end

def find_clipped_min_max(histogram, min, max)
  # histogram
  sum = histogram.inject(:+)
  three_percent = sum * 0.03
  lower_sum = 0
  upper_sum = 0
  last_lower_i = nil
  last_upper_i = nil

  histogram.each_with_index do |value, i|
    # summing up values in lower_sum til the sum is >= 3% of the sum of all data values
    # last_lower_i will be the data position right before lower_sum summed equal to 3% of the sum of all data values
    if lower_sum < three_percent
      lower_sum += value
      last_lower_i = i
    end

    # // the same with last_upper_i
    if upper_sum < three_percent
      upper_sum += histogram[histogram.size - 1 - i]
      last_upper_i = histogram.size - 1 - i
    end
  end

  {
    min: math_map_value(last_lower_i, 0, 255, min, max),
    max: math_map_value(last_upper_i, 0, 255, min, max)
  }
end

# return image bands depending of band_order
def bandsplit(image, band_order)
  if band_order == 'GRN'
    second, first, third, alpha = image.bandsplit
  else
    first, second, third, alpha = image.bandsplit
  end
  [first, second, third, alpha]
end

# apply image manipulation algebra
# VARI
def vari(image, band_order)
  r, g, b, alpha = bandsplit(image, band_order)
  index = (g - r) / (g + r - b)
  [alpha, index]
end

# NDVI
def ndvi(image, band_order)
  r, g, nir, alpha = bandsplit(image, band_order)
  index = (nir - r) / (nir + r)
  [alpha, index]
end

def apply_index(input_path, index)
  # load image
  image = Vips::Image.new_from_file("./#{input_path}")

  # call index method
  if index == 'NDVI'
    alpha, result = ndvi(image, 'RGN')
  elsif index == 'VARI'
    alpha, result = vari(image, 'RGB')
  end

  # it will be used to 'normalize' results
  histogram = result_histogram(result)
  clip_min_max = find_clipped_min_max(histogram, result.min, result.max)

  # normalize min/max
  min = clip_min_max[:min]
  max = clip_min_max[:max]

  # apply image manipulation algebra to 'normalize' results
  result = ((result - min) / (max - min).to_f) * 256

  # apply Look-Up-Table (LUT)
  rdylgn_image = Vips::Image.new_from_file('./rdylgn.png')
  rgb = result.maplut(rdylgn_image)

  # save to file
  rgb[0...3].bandjoin(alpha).write_to_file("./#{index.downcase}.png")
end

apply_index(ARGV[0], ARGV[1])
