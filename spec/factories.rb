Factory.define :user do |user|
     user.name                     "Vered Bauer"
     user.email                    "vered@gmail.com"
     user.password                 "foobar"
     user.password_confirmation    "foobar"
end

Factory.sequence :email do |n|
   "person-#{n}@example.com"
end
