Role.create!([
                 {name: "admin", resource_type: nil, resource_id: nil},
                 {name: "normal", resource_type: nil, resource_id: nil},
                 {name: "pro_user_1", resource_type: nil, resource_id: nil},
                 {name: "pro_user_2", resource_type: nil, resource_id: nil},
                 {name: "pro_user_3", resource_type: nil, resource_id: nil}
             ])

User.create!([
                 {email: "admin@gmail.com", password: "password", name: "admin", gender: "m", dob: "09/13/2019"},
                 {email: "amy@gmail.com", password: "password", name: "amy", gender: "m", dob: "09/13/2019"},
                 {email: "penny@gmail.com", password: "password", name: "penny", gender: "f", dob: "09/19/2019"}
             ])