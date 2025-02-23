import React from "react";
import { useNavigate } from "react-router-dom";
import "../styles/Courses.css";

const courses = [
  { id: 1, name: "Web Development", level: "Beginner", desc: "Learn HTML, CSS, and JavaScript from scratch.", img: "/assets/web.png" },
  { id: 2, name: "Data Science", level: "Intermediate", desc: "Master data analysis, visualization, and machine learning.", img: "/assets/ds.png" },
  { id: 3, name: "AI & Machine Learning", level: "Advanced", desc: "Deep dive into neural networks and AI concepts.", img: "/assets/aiml.png" },
  { id: 4, name: "Cybersecurity", level: "Beginner", desc: "Protect systems and data from cyber threats.", img: "/assets/cyber.png" },
  { id: 5, name: "Mobile App Development", level: "Intermediate", desc: "Create Android & iOS apps using React Native.", img: "/assets/mob.png" },
  { id: 6, name: "Blockchain Development", level: "Advanced", desc: "Build decentralized applications on Ethereum.", img: "/assets/bc.png" },
  { id: 7, name: "Digital Marketing", level: "Beginner", desc: "Boost your brand with SEO, SEM, and social media.", img: "/assets/dm.png" },
  { id: 8, name: "Graphic Design", level: "Intermediate", desc: "Create stunning visuals with Photoshop & Illustrator.", img: "/assets/gr.png" },
  { id: 9, name: "Cloud Computing", level: "Advanced", desc: "Master AWS, Google Cloud, and Azure services.", img: "/assets/cloud.png" },
  { id: 10, name: "Game Development", level: "Beginner", desc: "Develop 2D and 3D games using Unity & Unreal.", img: "/assets/gam.jpg" },
  { id: 11, name: "Business Analytics", level: "Intermediate", desc: "Analyze business data for better decision-making.", img: "/assets/ba.png" },
];

const Courses = () => {
  const navigate = useNavigate();

  return (
    <section id="courses" className="courses-section">
      {/* Home Button */}
      <button className="home-btn" onClick={() => navigate("/")}>🏠 Home</button>

      <h2>Explore Our Courses</h2>
      <p>Choose from a variety of courses tailored to your needs</p>

      <div className="courses-container">
        {courses.map((course) => (
          <div key={course.id} className="course-card">
            <img src={course.img} alt={course.name} className="course-img" />
            <h3>{course.name}</h3>
            <p className="course-level">{course.level}</p>
            <p className="course-desc">{course.desc}</p>
            <button className="enroll-btn" onClick={() => navigate(`/enroll/${course.id}`)}>
              Enroll Now
            </button>
          </div>
        ))}
      </div>
    </section>
  );
};

export default Courses;
