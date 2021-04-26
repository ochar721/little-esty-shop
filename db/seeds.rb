# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
BulkDiscount.destroy_all

20.times do
  BulkDiscount.create(name: ["Halloween", "Christmas", "Ksenyia Day"].sample, percent: [20, 5, 10].sample, quantity_threshold: [4, 5, 8, 10].sample, merchant_id: [1, 2].sample )
end
