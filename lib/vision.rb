require "google/cloud/vision"
require 'mini_magick'


class Vision

	def self.Take_Photo(path = 'temp_file.jpg')
		added_file = Vision.look_for_airdropped_photos
		return added_file if added_file
		system("imagesnap -w 3 #{path}")
		return 'temp_file.jpg'
	end

	def self.look_for_airdropped_photos
		original_directory = Dir::entries('/Users/aditpatel/Downloads')
		last_scan = Dir::entries('/Users/aditpatel/Downloads')
		i = 0
		while (original_directory == last_scan && i < 90)
			last_scan = Dir::entries('/Users/aditpatel/Downloads')
			sleep(1)
			i += 1
			puts "You have #{90 - i} seconds left"
		end
		system ("say Thanks I got the photo")
		system('clear')
		box = TTY::Box.success("Processing Image")
		print box
		puts "This part takes me a minute, just give me some time to think, okay?"
		sleep(3)
		new_path = '/Users/aditpatel/Downloads/' + (last_scan - original_directory)[0]
		resulting_path = Vision.prep_image_for_upload(new_path)
		return resulting_path
	end

	def self.Check_Photo_Stuff(path)

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

	def self.Check_Photo_Faces(path)

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
			"Microwave oven",
			"Refrigerator",
			"Computer keyboard"
		]
		return result
	end

	def self.prep_image_for_upload(path)
		image = MiniMagick::Image.open(path)
		if image.type == 'HEIC'
			image.strip
			if image.portrait?
				image.format "png"
				image.write "/Users/aditpatel/Downloads/google_upload.png"
			else
				image.format "png"
				image.rotate 90
				image.write "/Users/aditpatel/Downloads/google_upload.png"
			end
			return "/Users/aditpatel/Downloads/google_upload.png"
		else
			return path
		end
		system('clear')
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
