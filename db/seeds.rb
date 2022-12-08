# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!({
    username: "admin",
    role: "admin",
    password: "admin" 
})

User.create!({
    username: "cliente",
    role: "client",
    password: "123" 
})

BranchOffice.create!({
    name: "sucursal 1",
    direc: "direccion",
    tel: "123",
    schedule: Schedule.create!({
        mondayInit: "10:00:00",
        mondayFinish: "20:00:00",
        tuesdayInit: "10:00:00",
        tuesdayFinish: "20:00:00",
        wednesdayInit: "10:00:00",
        wednesdayFinish: "20:00:00",
        thursdayInit: "10:00:00",
        thursdayFinish: "20:00:00",
        fridayInit: "10:00:00",
        fridayFinish: "20:00:00",
        saturdayInit: "10:00:00",
        saturdayFinish: "20:00:00",
        sundayInit: "10:00:00",
        sundayFinish: "20:00:00",
    })
})