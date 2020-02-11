require "google/cloud/vision"

class Vision

	def self.Take_Photo(path = 'temp_file.jpg')
		system("imagesnap -w 3 #{path}")
	end

	def self.Check_Photo_Stuff(path = 'temp_file.jpg')

		objects_found_in_image = []

		image_annotator = Google::Cloud::Vision::ImageAnnotator.new

		response = image_annotator.object_localization_detection image: path

		response.responses.each do |res|
			res.localized_object_annotations.each do |object|
				objects_found_in_image << object.name
			end
		end

		return objects_found_in_image

	end

	def self.Check_Photo_Faces(path = 'temp_file.jpg')

		result = []

		image_annotator = Google::Cloud::Vision::ImageAnnotator.new

		response2 = image_annotator.face_detection image: path

		response2.responses.each do |res|
			res.face_annotations.each do |face|
				 result << {
					joy: face.joy_likelihood, 
					anger: face.anger_likelihood, 
					sorrow: face.sorrow_likelihood, 
					surprise: face.surprise_likelihood
				}
			end
		end
		return result
	end

	def self.recognized_objects
		result = [
			"Stapler",
			"Mug",
			"Chair",
			"Laptop",
			"Stool",
			"Microwave",
			"Computer keyboard"
		]
		return result
	end
end

# system('imagesnap -w 3 temp_file.jpg')

# image_path = './temp_file.jpg'

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
