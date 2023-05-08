task :assign_role_to_admin, [:email] => :environment do |t,arg|
  User.find_by(email: arg[:email]).update_columns(role: 'admin')
end
