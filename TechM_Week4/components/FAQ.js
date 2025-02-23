import React, { useState } from "react";
import "../styles/FAQ.css";

const faqs = [
  {
    question: "What is EduVantage?",
    answer: "EduVantage is an online education platform offering high-quality courses for learners worldwide.",
  },
  {
    question: "How do I enroll in a course?",
    answer: "Simply visit the Courses page, select your desired course, and click the 'Enroll' button.",
  },
  {
    question: "Is there a certificate after course completion?",
    answer: "Yes! Upon successful completion of any course, you will receive a certificate.",
  },
  {
    question: "Can I access the courses for free?",
    answer: "Some courses are free, while others require a one-time payment or subscription.",
  },
];

const FAQ = () => {
  const [openIndex, setOpenIndex] = useState(null);

  const toggleFAQ = (index) => {
    setOpenIndex(openIndex === index ? null : index);
  };

  return (
    <div className="faq-container">
      <h2>Frequently Asked Questions</h2>
      <div className="faq-list">
        {faqs.map((faq, index) => (
          <div key={index} className="faq-item">
            <div className="faq-question" onClick={() => toggleFAQ(index)}>
              {faq.question}
              <span>{openIndex === index ? "▲" : "▼"}</span>
            </div>
            {openIndex === index && <div className="faq-answer">{faq.answer}</div>}
          </div>
        ))}
      </div>
    </div>
  );
};

export default FAQ;
