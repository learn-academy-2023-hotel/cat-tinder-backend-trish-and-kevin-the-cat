user1 = User.where(email: 'test1@example.com').first_or_create(password:'password', password_confirmation:'password')
user2 = User.where(email: 'test2@example.com').first_or_create(password:'password', password_confirmation:'password')

user1_cats = [
          { 
            name: 'Kevin',
            age: 9,
            enjoys: 'Talking to the dogs walking by the window',
            image: 'https://upload.wikimedia.org/wikipedia/commons/e/e4/Tuxedo_cat_Vladimir_124.jpg'
          },
          { 
            name: 'Geppetto',
            age: 8,
            enjoys: 'being outside in the sun',
            image: 'https://www.publicdomainpictures.net/pictures/200000/nahled/ragdoll-cat-with-green-eyes-14766395657Vf.jpg'
          }
        ]

user2_cats =[        
          { 
            name: 'Priscilla',
            age: 13,
            enjoys: 'Wanting attention from all humans. Only humans',
            image: 'https://petkeen.com/wp-content/uploads/2021/04/Blue-norwegian-forest-cat_Elisa-Putti_Shutterstock-760x507.jpg'
          }
]


user1_cats.each do |cat|
  user1.cats.create cat
  puts "creating cat #{cat}"
end

user2_cats.each do |cat|
  user2.cats.create cat
  puts "creating cat #{cat}"
end