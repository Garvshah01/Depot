task :assign_role_to_admin, [:email] => :environment do |t,arg|
  User.where(email: arg[:email]).each do |user|
    user.update_columns(role: 'admin')
  end
end
