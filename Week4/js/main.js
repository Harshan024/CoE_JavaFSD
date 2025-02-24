import { courses, instructors } from "./data.js";
document.addEventListener("DOMContentLoaded", () => {
    const currentPage = window.location.pathname.split("/").pop();
    switch (currentPage) {
        case "":
        case "index.html":
            initHomePage();
            break;
        case "courses.html":
            initCoursesPage();
            break;
        case "instructors.html":
            initInstructorsPage();
            break;
        case "enrollment.html":
            initEnrollmentPage();
            break;
    }
});
function initHomePage() {
    renderFeaturedCourses();
    initTabs();
}
function initCoursesPage() {
    renderAllCourses();
    initSearch();
}
function initInstructorsPage() {
    renderInstructors();
}
function initEnrollmentPage() {
    populateCourseSelect();
    initEnrollmentForm();
}
function renderFeaturedCourses() {
    const carousel = document.querySelector(".carousel");
    const featuredCourses = courses.filter((course) => course.featured);
    featuredCourses.forEach((course) => {
        const courseCard = createCourseCard(course);
        carousel.appendChild(courseCard);
    });
}
function initTabs() {
    const tabButtons = document.querySelectorAll(".tab-button");
    const tabContent = document.querySelector(".tab-content");
    tabButtons.forEach((button) => {
        button.addEventListener("click", () => {
            const category = button.dataset.category;
            tabButtons.forEach((btn) => btn.classList.remove("active"));
            button.classList.add("active");
            if (category) {
                renderCoursesByCategory(category);
            }
        });
    });
    // Initialize with 'All' category
    renderCoursesByCategory("all");
}
function renderCoursesByCategory(category) {
    const tabContent = document.querySelector(".tab-content");
    tabContent.innerHTML = "";
    const filteredCourses = category === "all" ? courses : courses.filter((course) => course.category === category);
    filteredCourses.forEach((course) => {
        const courseCard = createCourseCard(course);
        tabContent.appendChild(courseCard);
    });
}
function renderAllCourses() {
    const coursesGrid = document.querySelector(".courses-grid");
    courses.forEach((course) => {
        const courseCard = createCourseCard(course);
        coursesGrid.appendChild(courseCard);
    });
}
function initSearch() {
    const searchInput = document.getElementById("course-search");
    searchInput.addEventListener("input", () => {
        const searchTerm = searchInput.value.toLowerCase();
        const filteredCourses = courses.filter((course) => course.title.toLowerCase().includes(searchTerm) || course.instructor.toLowerCase().includes(searchTerm));
        renderFilteredCourses(filteredCourses);
    });
}
function renderFilteredCourses(filteredCourses) {
    const coursesGrid = document.querySelector(".courses-grid");
    coursesGrid.innerHTML = "";
    filteredCourses.forEach((course) => {
        const courseCard = createCourseCard(course);
        coursesGrid.appendChild(courseCard);
    });
}
function renderInstructors() {
    const instructorsGrid = document.querySelector(".instructors-grid");
    instructors.forEach((instructor) => {
        const instructorCard = createInstructorCard(instructor);
        instructorsGrid.appendChild(instructorCard);
    });
}
function populateCourseSelect() {
    const courseSelect = document.getElementById("course-select");
    courses.forEach((course) => {
        const option = document.createElement("option");
        option.value = course.id.toString();
        option.textContent = course.title;
        courseSelect.appendChild(option);
    });
}
function initEnrollmentForm() {
    const form = document.getElementById("enrollment-form");
    form.addEventListener("submit", (e) => {
        e.preventDefault();
        const formData = new FormData(form);
        const enrollmentData = Object.fromEntries(formData.entries());
        console.log("Enrollment data:", enrollmentData);
        // Here you would typically send this data to a server
        alert("Enrollment submitted successfully!");
        form.reset();
    });
}
function createCourseCard(course) {
    const card = document.createElement("div");
    card.className = "course-card";
    card.innerHTML = `
        <img src="${course.image}" alt="${course.title}">
        <div class="course-card-content">
            <h3>${course.title}</h3>
            <p>Instructor: ${course.instructor}</p>
            <p>Duration: ${course.duration}</p>
            <p>Price: $${course.price}</p>
        </div>
    `;
    return card;
}
function createInstructorCard(instructor) {
    const card = document.createElement("div");
    card.className = "instructor-card";
    card.innerHTML = `
        <img src="${instructor.image}" alt="${instructor.name}">
        <div class="instructor-card-content">
            <h3>${instructor.name}</h3>
            <p>${instructor.expertise}</p>
        </div>
    `;
    return card;
}
