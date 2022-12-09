BranchOffice.create!({
    name: "sucursal",
    direc: "20 n°1677",
    tel: "2215411339",
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
        saturdayInit: "00:00:00",
        saturdayFinish: "00:00:00",
        sundayInit: "00:00:00",
        sundayFinish: "00:00:00",
    })
})

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

User.create!({
    username: "personal",
    role: "staff",
    password: "123",
    branch_office: BranchOffice.find(1)
})
