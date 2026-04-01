User.find_or_create_by!(email_address: "admin@example.com") do |u|
  u.password = "password123"
  u.role = :admin
end

User.find_or_create_by!(email_address: "user@example.com") do |u|
  u.password = "password123"
  u.role = :regular
end

puts "Seeds created: admin@example.com and user@example.com (password: password123)"
