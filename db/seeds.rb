# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
file = File.read(File.join(Rails.root, 'db', 'seeds_source', 'models.json'))
data = JSON.parse(file, symbolize_names: true)

grouped_models = data.group_by{ _1[:brand_name] }
brands = grouped_models.keys.uniq.sort

ActiveRecord::Base.transaction do
  brands.each do |brand_name|
    puts "creating brand #{brand_name}"

    brand = Brand.create(name: brand_name)
    models_data = grouped_models[brand_name].map { { name: _1[:name], average_price: _1[:average_price] } }
    puts 'creating brand models'
    brand.models.insert_all(models_data)
  end
rescue StandardError => e
  puts 'error trying to insert'
  puts e
end

puts 'Finished'
