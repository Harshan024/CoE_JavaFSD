import React from "react";
import { useNavigate } from "react-router-dom";
import "../styles/Instructors.css";

const instructors = [
  { id: 1, name: "John Smith", expertise: "Web Development", bio: "Experienced full-stack developer with expertise in React and Node.js.", img: "/assets/tom.png" },
  { id: 2, name: "Alice Johnson", expertise: "Data Science", bio: "Data scientist specializing in AI and machine learning.", img: "/assets/alice.png" },
  { id: 3, name: "Michael Brown", expertise: "Cybersecurity", bio: "Cybersecurity analyst with 10+ years in ethical hacking.", img: "/assets/mike.png" },
  { id: 4, name: "Emily White", expertise: "Digital Marketing", bio: "Marketing strategist helping brands grow online.", img: "/assets/emily.png" },
  { id: 5, name: "David Lee", expertise: "Cloud Computing", bio: "AWS-certified architect with deep cloud expertise.", img: "/assets/james.png" },
];

const Instructors = () => {
  const navigate = useNavigate();

  return (
    <section id="instructors" className="instructors-section">
      {/* Home Button */}
      <button className="home-btn" onClick={() => navigate("/")}>🏠 Home</button>

      <h2>Meet Our Instructors</h2>
      <p>Learn from industry-leading experts.</p>

      <div className="instructors-container">
        {instructors.map((instructor) => (
          <div key={instructor.id} className="instructor-card">
            <img src={instructor.img} alt={instructor.name} className="instructor-img" />
            <h3>{instructor.name}</h3>
            <p className="expertise">{instructor.expertise}</p>
            <p className="bio">{instructor.bio}</p>
            <button className="view-profile-btn" onClick={() => navigate(`/instructor/${instructor.id}`)}>
              View Profile
            </button>
          </div>
        ))}
      </div>
    </section>
  );
};

export default Instructors;
