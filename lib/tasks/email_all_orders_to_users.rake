task :email_all_orders_to_users => :environment do
  User.all.each do |user|
    OrderMailer.all_orders(user.orders)
  end
end
