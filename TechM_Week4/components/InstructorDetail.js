import React from "react";
import { useParams, useNavigate } from "react-router-dom";
import "../styles/InstructorDetail.css";


const instructors = [
  { id: 1, name: "John Smith", expertise: "Web Development", bio: "Experienced full-stack developer with expertise in React and Node.js. John has worked with top tech firms and contributed to multiple open-source projects.", img: "/assets/tom.png" },
  { id: 2, name: "Alice Johnson", expertise: "Data Science", bio: "Data scientist specializing in AI and machine learning. Alice has published numerous research papers and is a speaker at AI conferences.", img: "/assets/alice.png" },
  { id: 3, name: "Michael Brown", expertise: "Cybersecurity", bio: "Cybersecurity analyst with 10+ years in ethical hacking. Michael has helped companies secure their systems against cyber threats.", img: "/assets/mike.png" },
  { id: 4, name: "Emily White", expertise: "Digital Marketing", bio: "Marketing strategist helping brands grow online. Emily has worked with Fortune 500 companies and built successful marketing campaigns.", img: "/assets/emily.png" },
  { id: 5, name: "David Lee", expertise: "Cloud Computing", bio: "AWS-certified architect with deep cloud expertise. David has assisted organizations in migrating to the cloud seamlessly.", img: "/assets/james.png" },
];

const InstructorDetail = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const instructor = instructors.find((inst) => inst.id === parseInt(id));

  if (!instructor) {
    return <p>Instructor not found</p>;
  }

  return (
    <div className="instructor-detail-container">
      <div className="instructor-card-detail">
        <img src={instructor.img} alt={instructor.name} className="instructor-img-detail" />
        <h2>{instructor.name}</h2>
        <h3>{instructor.expertise}</h3>
        <p>{instructor.bio}</p>
        <button className="back-btn" onClick={() => navigate("/instructors")}>
        ⬅ Return to Instructors
      </button>
      </div>
    </div>
  );
};

export default InstructorDetail;
