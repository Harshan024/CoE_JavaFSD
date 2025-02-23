import React, { useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import "../styles/EnrollmentForm.css";

const courses = [
  { id: 1, name: "Web Development"},
  { id: 2, name: "Data Science" },
  { id: 3, name: "AI & Machine Learning" },
  { id: 4, name: "Cybersecurity"},
  { id: 5, name: "Mobile App Development"},
  { id: 6, name: "Blockchain Development"},
  { id: 7, name: "Digital Marketing"},
  { id: 8, name: "Graphic Design"},
  { id: 9, name: "Cloud Computing"},
  { id: 10, name: "Game Development"},
  { id: 11, name: "Business Analytics"},
];

const EnrollmentForm = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const course = courses.find((course) => course.id === parseInt(id));

  const [formData, setFormData] = useState({
    name: "",
    email: "",
    phone: "",
  });

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    alert(`Successfully enrolled in ${course?.title}`);
    navigate("/");
  };

  return (
    <section className="enrollment-page">

      <h2>Enroll in {course?.title || "a Course"}</h2>
      <p>Level: {course?.level}</p>

      <form className="enrollment-form" onSubmit={handleSubmit}>
        <label>Full Name:</label>
        <input type="text" name="name" required onChange={handleChange} />

        <label>Email:</label>
        <input type="email" name="email" required onChange={handleChange} />

        <label>Phone Number:</label>
        <input type="tel" name="phone" required onChange={handleChange} />

        <button type="submit" className="enroll-btn">Enroll Now</button>
      </form>

      {/* Return Button */}
      <button className="back-btn" onClick={() => navigate("/courses")}>
        ← Back to Courses
      </button>
    </section>
  );
};

export default EnrollmentForm;