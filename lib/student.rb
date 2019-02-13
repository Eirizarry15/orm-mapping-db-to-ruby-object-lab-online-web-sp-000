class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    new_student = self.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
  end

  def self.all
    sql = "SELECT * FROM students" 
    DB[:conn].execute(sql).map do |student_attributes|
      new_from_db(student_attributes)
    end 
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM students WHERE name = ?"
    result = DB[:conn].execute(sql,name)
    new_from_db(result[0])
 end
    
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

 def self.count_all_students_in_grade_9
    sql = "SELECT * FROM students WHERE grade = ?"
    DB[:conn].execute(sql,9).map do |return_array|
      new_from_db(return_array)
    end
  end
