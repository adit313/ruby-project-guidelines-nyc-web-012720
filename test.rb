system('export GOOGLE_APPLICATION_CREDENTIALS="/Users/aditpatel/flatironcode/projects/ruby-project-alt-guidelines-nyc-web-012720/mod1project.json"')

system('imagesnap -w 3 temp_file.jpg')

image_path = './temp_file.jpg'

require "google/cloud/vision"

image_annotator = Google::Cloud::Vision::ImageAnnotator.new

response = image_annotator.object_localization_detection image: image_path

response.responses.each do |res|
  res.localized_object_annotations.each do |object|
    puts "#{object.name} (confidence: #{object.score})"
  end
end

response2 = image_annotator.face_detection image: image_path

response2.responses.each do |res|
  res.face_annotations.each do |face|
    puts "Joy:      #{face.joy_likelihood}"
    puts "Anger:    #{face.anger_likelihood}"
    puts "Sorrow:   #{face.sorrow_likelihood}"
    puts "Surprise: #{face.surprise_likelihood}"
  end
end

