# system('export GOOGLE_APPLICATION_CREDENTIALS="/Users/aditpatel/flatironcode/projects/mod1project.json"')

# image_path = '/Users/aditpatel/Downloads/IMG_0769.jpg'


# require 'mini_magick'

# image = MiniMagick::Image.open("/Users/aditpatel/Downloads/IMG_0176.HEIC")
# image.path #=> "/var/folders/k7/6zx6dx6x7ys3rv3srh0nyfj00000gn/T/magick20140921-75881-1yho3zc.jpg"
# image.strip
# puts image.type
# puts image.portrait?
# if image.portrait?
# 	image.format "png"
# 	image.write "/Users/aditpatel/Downloads/google_upload.png"
# else
# 	image.format "png"
# 	image.rotate 90
# 	image.write "/Users/aditpatel/Downloads/google_upload.png"
# end



# require "google/cloud/vision"

# image_annotator = Google::Cloud::Vision::ImageAnnotator.new

# response = image_annotator.object_localization_detection image: image_path

# response.responses.each do |res|
#   res.localized_object_annotations.each do |object|
#     puts "#{object.name} (confidence: #{object.score})"
#   end
# end

# response2 = image_annotator.face_detection image: image_path

# response2.responses.each do |res|
#   res.face_annotations.each do |face|
#     puts "Joy:      #{face.joy_likelihood}"
#     puts "Anger:    #{face.anger_likelihood}"
#     puts "Sorrow:   #{face.sorrow_likelihood}"
#     puts "Surprise: #{face.surprise_likelihood}"
#   end
# end

