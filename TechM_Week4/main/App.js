import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "./components/Home";
import Courses from "./components/Courses";
import CourseDetail from "./components/CourseDetail";
import InstructorDetail from "./components/InstructorDetail";
import EnrollmentForm from "./components/EnrollmentForm";
import Instructors from "./components/Instructors";
import Navbar from "./components/Navbar";
import "./styles/Home.css";
import "./styles/CourseDetail.css";
import "./styles/InstructorDetail.css";
import "./styles/Navbar.css";
import Login from "./pages/Login";
import Signup from "./pages/Signup";
import Contact from "./components/Contact";
import FAQ from "./components/FAQ";

function App() {
  return (
    <Router>
      <Navbar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login />} />
        <Route path="/signup" element={<Signup />} />
        <Route path="/courses" element={<Courses />} />
        <Route path="/course/:id" element={<CourseDetail />} />
        <Route path="/instructors" element={<Instructors />} />
        <Route path="/instructor/:id" element={<InstructorDetail />} />
        <Route path="/enroll/:id" element={<EnrollmentForm />} />
        <Route path="/contact" element={<Contact />} />
        <Route path="/faq" element={<FAQ />} />
      </Routes>
    </Router>
  );
}

export default App;
