#!/bin/bash
#Info about my computer science students from students database

echo -e "\n~~ My Computer Science Students ~~\n"
PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"
echo -e "\nFirst name, last name, and GPA of students with a 4.0 GPA:"

echo "$($PSQL "select first_name,last_name,gpa from students where gpa=4.0")"
echo -e "\nAll course names whose first letter is before 'D' in the alphabet:"
echo "$($PSQL "select course from courses where course < 'D'")"
echo -e "\nFirst name, last name, and GPA of students whose last name begins with an 'R' or after and have a GPA greater than 3.8 or less than 2.0:"
echo "$($PSQL "select first_name,last_name,gpa from students where last_name >= 'R' AND (gpa > 3.8 OR gpa < 2.0)")"

echo -e "\nLast name of students whose last name contains a case insensitive 'sa' or have an 'r' as the second to last letter:"

echo "$($PSQL "select last_name from students where last_name ILIKE '%sa%' OR last_name LIKE '%r_'")"

echo -e "\nfirst name, last name, and GPA of students who have not selected a major and either their first name begins with 'D' or they have a GPA greater than 3.0:"
echo "$($PSQL "select first_name,last_name, gpa from students WHERE major_id is NULL AND (first_name LIKE 'D%' OR gpa > 3.0)")"

echo "$($PSQL "select major from majors  full join students on majors.major_id = students.major_id group by major having count(case when lower(first_name) like '%ma%' then 1 end) > 0 or count(students.major_id) = 0 order by majors.major;")"

echo -e "\nList of unique courses, in reverse alphabetical order, that no student or 'Obie Hilpert' is taking:"
echo "$($PSQL "select distinct course from students FULL JOIN majors USING(major_id) FULL JOIN majors_courses USING(major_id) FULL JOIN courses USING(course_id)
     where (first_name= 'Obie' and last_name='Hilpert') or students.major_id is null order by course desc;")"

echo -e "\nList of courses, in alphabetical order, with only one student enrolled:"
echo "$($PSQL "select course from students FULL JOIN majors USING(major_id) FULL JOIN majors_courses USING(major_id) FULL JOIN courses USING(course_id)
        group by course having count(students.student_id)=1 order by course asc;")"