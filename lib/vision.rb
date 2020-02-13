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
		Vision.clear
		box = TTY::Box.frame(width: 126, height: 10, align: :center, padding: 4, border: {type: :thick}, style: {fg: :bright_black, bg: :bright_cyan}) do
			"Processing your iPhone photo"
		end
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
				image.format "jpeg"
				image.write "/Users/aditpatel/Downloads/google_upload.jpeg"
			else
				image.format "jpeg"
				image.rotate 90
				image.write "/Users/aditpatel/Downloads/google_upload.jpeg"
			end

			image2 = MiniMagick::Image.open("/Users/aditpatel/Downloads/google_upload.jpeg")
			if image2.size > 10485760
				image2.resize "50%"
				image2.write "/Users/aditpatel/Downloads/google_upload.jpeg"
			end

			return "/Users/aditpatel/Downloads/google_upload.jpeg"

		else
			return path

		end
	end

	def self.clear
		system('clear')
		puts $pastel.bright_cyan.bold('MP""""""`MM                                                                            M""MMMMM""MM                     dP   
M  mmmmm..M                                                                            M  MMMMM  MM                     88   
M.      `YM .d8888b. .d8888b. dP   .dP .d8888b. 88d888b. .d8888b. .d8888b. 88d888b.    M         `M dP    dP 88d888b. d8888P 
MMMMMMM.  M 88`  `"" 88`  `88 88   d8` 88ooood8 88`  `88 88`  `88 88ooood8 88`  `88    M  MMMMM  MM 88    88 88`  `88   88   
M. .MMM`  M 88.  ... 88.  .88 88 .88`  88.  ... 88    88 88.  .88 88.  ... 88          M  MMMMM  MM 88.  .88 88    88   88   
Mb.     .dM `88888P` `88888P8 8888P`   `88888P` dP    dP `8888P88 `88888P` dP          M  MMMMM  MM `88888P` dP    dP   dP   
MMMMMMMMMMM                                                   .88                      MMMMMMMMMMMM                          
                                                          d8888P                                                             ')
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
