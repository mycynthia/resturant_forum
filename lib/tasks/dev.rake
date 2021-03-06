namespace :dev do
  # 產生五百筆餐廳假資料
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        image: File.open(File.join(Rails.root, "public/seed_img/#{rand(0...10)}.jpg"))
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end
  # 產生二十筆假使用者資料
  task fake_user: :environment do
    20.times do |i|
      user_name = FFaker::Name.first_name
      User.create!(
        email: "#{user_name}@example.com",
        password: "123456",
        name: "#{user_name}"
        )
    end
    puts "have created fake users,now have #{User.count} users data"
  end
  # 每筆餐廳資料下產生三筆評論
  task fake_comment: :environment do
    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
          )
      end
    end
    puts "have created fake comments,now have #{Comment.count} comment data "
  end
end
