# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  username: "transcendance",
  description: "Let's grind",
  email: "transcendancedotcom@gmail.com",
  password: "mindbodyspirit",
  admin: true
)

User.create(
    username: "iamAleph",
    description: "Let's grind",
    email: "frezoul.alex@gmail.com",
    password: "fdpntm",
    admin: true
)


User.create(
    username: "Kevin Lamidi",
    description: "Let's grind, baby",
    email: "lamidikevin@icloud.com",
    password: "Sylvie050393",
    admin: true
)

User.create(
    username: "Eugène Blivi",
    description: "Let's grind, baby",
    email: "eugene.blivi@gmail.com",
    password: "transcenance 0702",
    admin: true
)

User.create(
    username: "Ayoub Namrani",
    description: "Let's grind, baby",
    email: "retirewithayoub@gmail.com",
    password: "Ayoub1994@",
    admin: true
)