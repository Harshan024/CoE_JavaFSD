import React from "react";
import { useParams, Link } from "react-router-dom";
import "../styles/CourseDetail.css";

const courses = [
  { id: 1, name: "Beginner Java", level: "Beginner", description: "Learn Java from scratch." },
  { id: 2, name: "Advanced Java", level: "Advanced", description: "Deep dive into Java development." },
  { id: 3, name: "Python for Data Science", level: "Intermediate", description: "Python skills for data analysis." },
  { id: 4, name: "Machine Learning", level: "Advanced", description: "AI and machine learning concepts." }
];

const CourseDetail = () => {
  const { id } = useParams();
  const course = courses.find((c) => c.id === parseInt(id));

  if (!course) {
    return <h2>Course not found!</h2>;
  }

  return (
    <div className="course-detail">
      <h1>{course.name}</h1>
      <p>Level: {course.level}</p>
      <p>{course.description}</p>
      <Link to={`/enroll/${course.id}`} className="enroll-button">Enroll Now</Link>
    </div>
  );
};

export default CourseDetail;
