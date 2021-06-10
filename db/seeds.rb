# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

College.create(name: 'University of College', id: 1)
College.create(name: "Academy of University", id: 2)
College.create(name: "College of Naming Things", id: 3)
College.create(name: "University Community College", id: 4)
College.create(name: "Greensdale Community College", id: 5)

Exam.create(start: DateTime.new(2021,8,1), stop:DateTime.new(2021,8,5), college_id: 1, id: 222)
Exam.create(start: DateTime.new(2021,8,1), stop:DateTime.new(2021,8,5), college_id: 2, id: 333)
Exam.create(start: DateTime.new(2021,8,1), stop:DateTime.new(2021,8,5), college_id: 3, id: 444)
Exam.create(start: DateTime.new(2021,8,1), stop:DateTime.new(2021,8,5), college_id: 4, id: 555)
Exam.create(start: DateTime.new(2021,8,1), stop:DateTime.new(2021,8,5), college_id: 5, id: 666)

User.create(firstName: "Captain", lastName: "Levi", phoneNumber: "8824569874", id: 1, exam_id: 666)
User.create(firstName: "Mikasa", lastName: "Ackerman", phoneNumber: "7701134562", id: 2, exam_id: 555)
