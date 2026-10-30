<script setup>
import { computed, onMounted, ref, watch } from 'vue'
import SiteHeader from './components/SiteHeader.vue'
import HeroSection from './components/HeroSection.vue'
import AboutSection from './components/AboutSection.vue'
import ProjectCard from './components/ProjectCard.vue'
import CursorGlow from './components/CursorGlow.vue'
import ToolkitSlider from './components/ToolkitSlider.vue'
import DigitalStudio from './components/DigitalStudio.vue'
import './assets/portfolio.css'

const activeProjectFilter = ref('All projects')
const projectSearch = ref('')
const projectFilters = ['All projects', 'Full-stack', 'Data & scraping', 'HR technology']
const visibleProjects = computed(() => {
  let filtered = projects.value
  if (activeProjectFilter.value === 'Full-stack') filtered = filtered.filter((project) => project.name === 'WeConnect')
  if (activeProjectFilter.value === 'Data & scraping') filtered = filtered.filter((project) => project.name === 'Lightning News')
  if (activeProjectFilter.value === 'HR technology') filtered = filtered.filter((project) => project.name === 'Modern Tech')
  const query = projectSearch.value.trim().toLowerCase()
  if (!query) return filtered
  return filtered.filter((project) =>
    [project.name, project.type, project.description, project.focus, project.challenge, project.approach, project.learning, ...project.tags]
      .filter(Boolean)
      .some((value) => value.toLowerCase().includes(query)),
  )
})
const journeyFilter = ref('all')
const themeDark = ref(false)
onMounted(() => {
  themeDark.value = window.localStorage.getItem('zanda-portfolio-theme') === 'dark'
})
watch(themeDark, (isDark) => {
  if (typeof window !== 'undefined') {
    window.localStorage.setItem('zanda-portfolio-theme', isDark ? 'dark' : 'light')
  }
})
const journeyPaused = ref(false)
const journeyFilters = [
  { label: 'Everything', value: 'all' },
  { label: 'Learning', value: 'learning' },
  { label: 'Projects', value: 'project' },
  { label: 'Credentials', value: 'credential' },
]
const journeyItems = [
  {
    id: 'training', type: 'learning', when: 'APRIL – OCTOBER 2026', status: 'COMPLETED',
    title: 'Trainee Developer Programme', org: 'Life Choices Coding Academy',
    description: 'Six months of hands-on coding, debugging and team projects that helped me build my development foundations.',
    skills: ['Development foundations', 'Debugging', 'Team projects'],
    detailLabel: 'What I took with me', detail: 'I stopped treating an error as a dead end. Reading the message, testing one change at a time and asking clearer questions gave me a more patient problem-solving process.',
    link: '#achievements', linkLabel: 'See my learning milestones',
  },
  {
    id: 'weconnect', type: 'project', when: 'ALONG THE WAY', status: 'PROJECT',
    title: 'WeConnect', org: 'Full-stack · Vue / Node / MySQL',
    description: 'A supplier network bringing buyers and suppliers into one clear workspace.',
    skills: ['Vue.js', 'Express', 'MySQL'],
    detailLabel: 'My contributions', detail: 'Supplier-side navigation and pages, styling for the buyer-side shop, Express routes and controllers, MySQL schema and queries, plus Git collaboration and testing.',
    link: '#project-01', linkLabel: 'Explore WeConnect',
  },
  {
    id: 'modern-tech', type: 'project', when: 'ALONG THE WAY', status: 'PROJECT',
    title: 'Modern Tech', org: 'HR technology · web application',
    description: 'An HR management experience for employee profiles, leave requests and calendars, designed around thoughtful workflows.',
    skills: ['JavaScript', 'Node.js', 'MySQL'],
    detailLabel: 'What it taught me', detail: 'Connecting interface states to backend logic, thinking through authentication and data relationships, and tracing bugs across API and database layers.',
    link: '#project-02', linkLabel: 'Explore Modern Tech',
  },
  {
    id: 'lightning-news', type: 'project', when: 'ALONG THE WAY', status: 'PROJECT',
    title: 'Lightning News', org: 'Data · web scraping · analytics',
    description: 'A dashboard that gathers stories from several sources with search and filtering.',
    skills: ['Python', 'Flask', 'Vue.js'],
    detailLabel: 'My contributions', detail: 'BeautifulSoup parsing and data extraction, plus Python/Flask backend work supporting the scraping workflow.',
    link: '#project-03', linkLabel: 'Explore Lightning News',
  },
  {
    id: 'credentials', type: 'credential', when: 'CREDENTIALS', status: 'CISCO',
    title: 'Cybersecurity & Data Science', org: 'Cisco badges · verifiable online',
    description: 'Foundations in passwords, encryption, firewalls and privacy, alongside the data lifecycle and data-driven thinking.',
    skills: ['Cybersecurity', 'Data science'],
    detailLabel: 'Why they matter', detail: 'They widen my view beyond building features: security and data thinking now shape how I design, test and question my own work.',
    link: '#achievements', linkLabel: 'View credentials',
  },
  {
    id: 'internship', type: 'learning', when: 'OCTOBER 2026 – APRIL 2027', status: 'IN PROGRESS', current: true,
    title: 'Developer Internship', org: 'LC Studio',
    description: 'Applying those foundations in a professional environment, one real task at a time.',
    skills: ['Practical experience', 'Feedback', 'Continued learning'],
    detailLabel: 'What I want to practise', detail: 'Asking thoughtful questions, learning from feedback, strengthening my technical decisions and seeing how small contributions fit a wider team effort.',
    link: '#blog', linkLabel: 'Read my field notes',
  },
]
const visibleJourneyItems = computed(() =>
  journeyFilter.value === 'all' ? journeyItems : journeyItems.filter((item) => item.type === journeyFilter.value),
)
const terminalCommand = ref('')
const terminalOutput = ref('Try: help, about, skills, projects, contact')

const menuOpen = ref(false)
const currentJournalIndex = ref(0)
const blogPosts = ref([
  {
    slug: 'trust-the-process',
    category: 'GROWTH & MINDSET',
    publishedAt: 'OCT 2026',
    tags: ['Debugging', 'Problem-solving'],
    takeaway: 'Slow down. Read the clues. Test one change at a time.',
    readingMinutes: 3,
    title: 'Learning to Trust My Problem-Solving Process',
    excerpt: 'The first instinct is not always the answer. Sometimes the real skill is slowing down, asking better questions and following the clues.',
    content: 'As a trainee developer, debugging has taught me that progress is rarely a straight line. When something breaks, I am learning to pause, read the error carefully and break the problem into smaller pieces instead of changing everything at once.\n\nTesting one idea at a time helps me understand what actually fixed the issue. The mistakes can be frustrating, but they are also clues. Every bug I work through gives me a little more confidence in my ability to investigate, learn and try again.',
    imageUrl: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=1200&q=85',
    imageAlt: 'A focused workspace with a laptop and notes',
    imageNote: 'ONE BUG AT A TIME',
  },
  {
    slug: 'beyond-the-interface',
    category: 'BUILDING & LEARNING',
    publishedAt: 'OCT 2026',
    tags: ['Vue.js', 'APIs', 'MySQL'],
    takeaway: 'A feature is more than the screen — follow the data.',
    readingMinutes: 3,
    title: 'Building Beyond the Interface',
    excerpt: 'A page is only one part of the story. I am learning how components, APIs and databases work together to make an experience feel seamless.',
    content: 'Working on full-stack projects has helped me see the connections behind the screen. A frontend component needs useful data, an API needs to handle requests clearly, and a database needs to organise information reliably.\n\nOn projects such as WeConnect, I have had the chance to work across Vue components, Express routes and MySQL integration. It has made me think about the whole journey of a piece of information, not just how a page looks. The more I understand those connections, the better questions I can ask when something does not work.',
    imageUrl: 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=1200&q=85',
    imageAlt: 'A small team collaborating around a laptop',
    imageNote: 'CONNECTING THE PIECES',
  },
  {
    slug: 'from-trainee-to-intern',
    category: 'CAREER JOURNEY',
    publishedAt: 'OCT 2026',
    tags: ['Growth', 'Practice', 'Next chapter'],
    takeaway: 'Training gave me a foundation; the next step is to keep practising in real situations.',
    readingMinutes: 4,
    title: 'From Trainee to Intern: The Next Chapter',
    excerpt: 'Finishing one six-month chapter and starting another is a reminder that growth is not a finish line — it is a practice.',
    content: 'My six-month trainee period at Life Choices Coding Academy has come to an end, and I have started the next six months as an intern at LC Studio. It feels like a meaningful transition: I am taking the foundations I have been building and continuing to grow through practical experience.\n\nI am learning to value progress that is not always dramatic. Asking questions, being open to feedback, working through bugs and showing up ready to learn all count. I want to keep documenting the small lessons as well as the milestones, because those are part of the story too.',
    imageUrl: 'https://images.unsplash.com/photo-1521737711867-e3b97375f902?auto=format&fit=crop&w=1200&q=85',
    imageAlt: 'Colleagues sharing ideas around a table',
    imageNote: 'A NEW CHAPTER, SAME CURIOSITY',
  },
  {
    slug: 'teamwork-is-a-technical-skill',
    category: 'TEAMWORK & PRACTICE',
    publishedAt: 'OCT 2026',
    tags: ['Communication', 'Git', 'Collaboration'],
    takeaway: 'Good teamwork includes clear communication, small commits and shared problem-solving.',
    readingMinutes: 3,
    title: 'Teamwork Is a Technical Skill, Too',
    excerpt: 'Building with other people means learning to communicate clearly, trace changes and solve problems together.',
    content: 'Collaborative projects have shown me that development is not only about writing code. It also means understanding how your work fits into a shared goal, communicating when something is unclear, and being willing to investigate a problem with the team.\n\nGit workflows, testing and debugging are technical tools, but they also support collaboration. I am learning that it helps to explain what I changed, what I expected to happen and what actually happened. Clear notes and thoughtful questions can make a difficult bug feel more manageable for everyone.',
    imageUrl: 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=1200&q=85',
    imageAlt: 'A team collaborating around a table in a bright workspace',
    imageNote: 'BETTER TOGETHER',
  },
  {
    slug: 'design-is-part-of-the-experience',
    category: 'DESIGN & ACCESSIBILITY',
    publishedAt: 'OCT 2026',
    tags: ['UX', 'Accessibility', 'Responsive design'],
    takeaway: 'Make the next step clear for the person using it.',
    readingMinutes: 3,
    title: 'Design Is Part of the Experience',
    excerpt: 'Soft edges and thoughtful details are lovely, but good design also helps people understand what to do next.',
    content: 'I love creating interfaces that feel warm and welcoming, but I am learning that visual polish should always support the person using the product. Clear labels, readable contrast, responsive layouts and visible focus states are not extras; they help make an experience easier to use.\n\nI want my work to feel considered without becoming complicated. Sometimes that means refining spacing, simplifying a section or making an interaction more obvious. Those small decisions can make technology feel more human.',
    imageUrl: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=1200&q=85',
    imageAlt: 'A laptop and notebook on a calm, minimal desk',
    imageNote: 'DETAILS WITH PURPOSE',
  },
])
const currentJournalPost = computed(() => blogPosts.value[currentJournalIndex.value])
function moveJournal(direction) {
  currentJournalIndex.value = (currentJournalIndex.value + direction + blogPosts.value.length) % blogPosts.value.length
}
const achievements = ref([
  {
    achievement_id: 'cisco-introduction-to-cybersecurity',
    title: 'Introduction to Cybersecurity',
    issuer: 'Cisco',
    imageUrl: '/IC%20%20BADGE.png',
    status: 'completed',
    achievedOn: '2026-10-29',
    credentialUrl: 'https://www.credly.com/badges/f0b44bf4-8edf-4190-8070-e1c7e6486a22/public_url',
    description: 'Cybersecurity foundations: passwords, encryption, firewalls, privacy and ethics.',
  },
  {
    achievement_id: 'cisco-introduction-to-data-science',
    title: 'Introduction to Data Science',
    issuer: 'Cisco',
    imageUrl: '/introduction-to-data-science.png',
    status: 'completed',
    credentialUrl: 'https://www.credly.com/earner/earned/badge/775a80a2-7a1b-4ef7-b6a3-2b4b8101c5fc',
    description: 'An introduction to data science concepts, the data lifecycle, working with data, and how data can be explored to support insights and decisions.',
  },
])
const learningExperiences = ref([
  {
    id: 'life-choices-trainee',
    title: 'Trainee Developer Programme',
    imageUrl: '/LC%20Academy.jpg',
    issuer: 'Life Choices Coding Academy',
    statusLabel: 'TRAINEE PERIOD · COMPLETED',
    period: 'April – October 2026',
    description: 'Completed the first six-month trainee period, building my development foundations through hands-on coding, collaborative projects, problem-solving and debugging.',
  },
  {
    id: 'lc-studio-internship',
    title: 'Developer Internship',
    imageUrl: '/LC%20Studio.png',
    issuer: 'LC Studio',
    statusLabel: 'CURRENT INTERNSHIP · IN PROGRESS',
    period: 'October 2026 – April 2027',
    description: 'Started the second six-month stage of my journey as an intern at LC Studio, continuing to develop my technical skills and gain practical experience in a professional environment.',
  },
])
const completedAchievements = computed(() =>
  achievements.value.filter((item) => !item.status || item.status === 'completed'),
)
const learningAchievements = computed(() =>
  achievements.value.filter((item) => item.status === 'in_progress' || item.status === 'planned'),
)
const projects = ref([
  {
    number: '01',
    initials: 'WC',
    theme: 'chambray',
    type: 'FULL-STACK · VUE / NODE / MYSQL',
    name: 'WeConnect',
    description: 'A supplier network experience bringing buyers, suppliers and everyday business operations into one clear workspace.',
    tags: ['Vue.js', 'Express', 'MySQL'],
    focus: 'A supplier marketplace connecting product discovery and business workflows in one workspace.',
    challenge: 'Keeping the frontend, API and relational data model aligned as supplier and buyer features evolve.',
    approach: 'Vue.js provides the interface, Express handles server-side routes, and MySQL stores structured application data.',
    learning: 'Full-stack integration, relational data, reusable UI patterns and collaborative Git workflows.',
    role: 'Frontend and backend contributor',
    deliverables: ['Supplier-side navigation and pages', 'Buyer-side shop styling', 'Express API routes and controllers', 'MySQL schema, queries and database integration'],
    architecture: 'Vue.js component-based interface → Express REST API → MySQL relational database. The key integration point is keeping UI state and API responses consistent.',
    testingNotes: 'Recommended verification: test sign-in and role permissions, create and update records, validate empty/error/loading states, and confirm the UI reflects persisted database changes.',
    decisions: 'The project uses a separate frontend, API layer and relational data store to keep presentation, request handling and persistence responsibilities distinct.',
    nextSteps: 'Further polish can focus on end-to-end testing, consistent error states and verifying the deployed buyer, supplier and admin journeys.',
    contributions: [
      'Vue.js sidebar and navigation for the supplier side.',
      'Supplier-side frontend pages and reusable components.',
      'Styling for the shop section of the buyer side.',
      'Express API routes and controllers.',
      'MySQL schema work, queries and database integration.',
      'Aiven database connection and deployment configuration.',
      'Testing, debugging and Git collaboration.',
    ],
    url: 'https://weconnect-bir9.onrender.com/landing',
    demoUrl: 'https://weconnect-bir9.onrender.com/landing',
    adminUrl: 'https://weconnect-admin4.onrender.com',
    repoUrl: 'https://github.com/zahraamoerat/Project-3-E-Commerce1',
    adminRepoUrl: 'https://github.com/zahraamoerat/weconnect-admin',
    designUrl: 'https://www.figma.com/design/2HIrJehYpe7EYzPXBB0ppJ/Untitled?node-id=0-1&t=HYvPj1jjUSE7M4vk-1',
    demoAccounts: [
      { role: 'Small business', email: 'phelisa-final@weconnect.com', password: 'testpass123' },
      { role: 'Supplier', email: 'info@greenfieldsagri.co.za', password: 'GFPassword123!' },
    ],
    label: 'View live website',
  },
  {
    number: '02',
    initials: 'MT',
    theme: 'espresso',
    type: 'HR TECHNOLOGY · WEB APPLICATION',
    name: 'Modern Tech',
    description: 'An HR management experience for employee profiles, leave requests and calendars, with thoughtful workflows at its core.',
    tags: ['JavaScript', 'Node.js', 'MySQL'],
    focus: 'A central place for employee information and everyday HR workflows such as leave requests and calendar events.',
    challenge: 'Making sure employee-specific information and protected workflows stay connected to the correct database records.',
    approach: 'The application combines employee-facing pages with Node.js and Express routes backed by MySQL data.',
    learning: 'Connecting UI states to backend logic, thinking through authentication and data relationships, and debugging API/database issues.',
    role: 'Full-stack project contributor',
    deliverables: ['Employee profile and HR workflow concepts', 'Node.js and Express backend routes', 'MySQL-backed application data'],
    architecture: 'Employee-facing Vue/UI flows connect to Node.js and Express routes, with MySQL responsible for persistent employee and workflow records.',
    testingNotes: 'Recommended verification: validate login and authorization boundaries, test leave-request state changes, check date and required-field validation, and confirm records remain correct after refresh.',
    decisions: 'Keep employee data and HR actions tied to server-side identity and validated records rather than trusting client-side state alone.',
    nextSteps: 'A useful next step is to document the main user journeys and test authentication, permissions and data validation across each HR workflow.',
    url: 'https://github.com/Zandakumsha/Modern_Tech_2',
    repoUrl: 'https://github.com/Zandakumsha/Modern_Tech_2',
    label: 'Explore project',
  },
  {
    number: '03',
    initials: 'LN',
    theme: 'glacier',
    type: 'DATA · WEB SCRAPING · ANALYTICS',
    name: 'Lightning News',
    description: 'A news analytics dashboard that brings scraped stories together with search, filtering and export-friendly views.',
    tags: ['Python', 'Flask', 'Vue.js'],
    focus: 'A dashboard that gathers stories from multiple news sources and makes them easier to search and explore.',
    challenge: 'News sites can structure their pages differently, so scraped content needs to be parsed and presented consistently.',
    approach: 'BeautifulSoup supports HTML parsing, Flask exposes backend functionality, and Vue.js powers the interactive dashboard.',
    learning: 'Data extraction, handling inconsistent source markup, and joining backend scraping with frontend search and filtering.',
    role: 'Data extraction and backend contributor',
    deliverables: ['BeautifulSoup parsing and data extraction', 'Python/Flask backend work', 'Dashboard search and filtering experience'],
    architecture: 'A Python scraping/parsing workflow with BeautifulSoup and Flask provides data to a Vue.js dashboard for searching and filtering stories.',
    testingNotes: 'Recommended verification: test missing or changed HTML selectors, duplicate stories, unavailable source pages, malformed dates, empty results and export output.',
    decisions: 'Separate extraction from presentation so scraped content can be normalized before the dashboard searches and displays it.',
    nextSteps: 'Further improvements could include tests for changing page markup, clearer handling of unavailable sources and validation of exported data.',
    contributions: [
      'BeautifulSoup parsing and data extraction from web pages.',
      'Python/Flask backend work related to the scraping workflow.',
    ],
    url: 'https://lightning-news.netlify.app/',
    demoUrl: 'https://lightning-news.netlify.app/',
    repoUrl: 'https://github.com/Maiesha7-7Moohan/Team-Charlie',
    label: 'View live demo',
  },
])

// Keep verified personal contributions independent of API/database project records.
const individualContributions = {
  WeConnect: [
    'Vue.js sidebar and navigation for the supplier side.',
    'Supplier-side frontend pages and reusable components.',
    'Styling for the shop section of the buyer side.',
    'Express API routes and controllers.',
    'MySQL schema work, queries and database integration.',
    'Aiven database connection and deployment configuration',
    'Testing, debugging and Git collaboration.',
  ],
  'Lightning News': [
    'BeautifulSoup parsing and data extraction from web pages.',
    'Python/Flask backend work related to the scraping workflow.',
  ],
}

function closeMenu() {
  menuOpen.value = false
}
function runTerminal() {
  const command = terminalCommand.value.trim().toLowerCase()
  const replies = { help: 'Commands: help · about · skills · projects · contact', about: 'I’m Zanda — a developer who loves thoughtful, human-centred digital experiences.', skills: 'Vue.js · JavaScript · HTML/CSS · Node.js · Express · MySQL · Python · Flask', projects: 'WeConnect · Modern Tech · Lightning News', contact: 'Scroll to the contact section and say hello ✳' }
  terminalOutput.value = replies[command] || 'Command not found. Try help'
  terminalCommand.value = ''
}
</script>

<template>
  <div class="site-shell" :class="{ 'theme-dark': themeDark }">
    <a class="skip-link" href="#main-content">Skip to content</a>
    <SiteHeader v-model:menu-open="menuOpen" :theme-dark="themeDark" @toggle-theme="themeDark = !themeDark" />

    <main id="main-content" tabindex="-1">
      <HeroSection />

      <div class="manifesto">
        <div class="manifesto-inner portfolio-status-strip">
          <span class="mini-label">CURRENT FOCUS</span>
          <p>Building useful things. Learning as I go.</p>
          <a href="#work">Browse selected work <span aria-hidden="true">↘</span></a>
        </div>
      </div>

      <AboutSection />

      <DigitalStudio />

      <section id="work" class="work-section">
        <div class="page-wrap content-section">
          <p class="section-kicker"><span>02</span> PROJECT ARCHIVE · SELECTED WORK</p>
          <div class="work-heading">
            <h2>Projects &amp; <em>case studies.</em></h2>
            <p>Selected builds. Real contributions. Lessons learned.</p>
          </div>
          <div class="project-discovery">
            <div class="project-filters" role="group" aria-label="Filter projects by category">
              <button v-for="filter in projectFilters" :key="filter" type="button" class="project-filter" :class="{ 'is-active': activeProjectFilter === filter }" :aria-pressed="activeProjectFilter === filter" @click="activeProjectFilter = filter">{{ filter }}</button>
            </div>
            <label class="project-search">
              <span aria-hidden="true">⌕</span>
              <span class="sr-only">Search projects by name or technology</span>
              <input v-model="projectSearch" type="search" placeholder="Search projects or technologies…" />
              <button v-if="projectSearch" type="button" aria-label="Clear project search" @click="projectSearch = ''">Clear</button>
            </label>
          </div>
          <p class="project-count" aria-live="polite">Showing {{ visibleProjects.length }} of {{ projects.length }} projects<span v-if="projectSearch"> matching “{{ projectSearch }}”</span></p>
          <div v-if="visibleProjects.length" class="project-grid">
            <ProjectCard
              v-for="project in visibleProjects"
              :key="project.number"
              :project="project"
              :individual-contributions="individualContributions"
            />
          </div>
          <div v-else class="project-empty-state">
            <span aria-hidden="true">✳</span>
            <h3>No projects found just yet.</h3>
            <p>Try another project name or technology, or clear your filters to explore all selected work.</p>
            <button type="button" @click="projectSearch = ''; activeProjectFilter = 'All projects'">Show all projects</button>
          </div>
          <div class="more-note"><span>✳</span> MORE IDEAS ARE ALWAYS IN THE MAKING <i></i></div>
        </div>
      </section>

      <ToolkitSlider />

      <section id="journey" class="journey-section page-wrap">
        <p class="section-kicker"><span>04</span> THE JOURNEY SO FAR</p>
        <h2 class="journey-heading">Built through <em>curiosity and practice.</em></h2>
        <p class="journey-intro">From trainee to intern, with projects and lessons along the way. Follow the line to see how each chapter shaped me.</p>

        <div class="timeline-toolbar" role="group" aria-label="Filter journey timeline">
          <button v-for="filter in journeyFilters" :key="filter.value" type="button" class="timeline-chip" :class="{ 'is-active': journeyFilter === filter.value }" :aria-pressed="journeyFilter === filter.value" @click="journeyFilter = filter.value">{{ filter.label }}</button>
        </div>

        <div class="timeline-carousel-controls">
          <p class="timeline-carousel-hint">A few chapters along the way <span aria-hidden="true">→</span></p>
          <button type="button" class="timeline-chip timeline-pause-toggle" :aria-pressed="journeyPaused" @click="journeyPaused = !journeyPaused">{{ journeyPaused ? 'Resume motion' : 'Pause motion' }}</button>
        </div>
        <div class="portfolio-timeline timeline-carousel" :class="{ 'is-paused': journeyPaused }" aria-label="Continuously scrolling developer journey carousel">
          <div v-if="visibleJourneyItems.length" class="timeline-marquee">
            <div class="timeline-marquee-group">
              <article v-for="(item, index) in visibleJourneyItems" :key="'first-' + item.id" class="portfolio-timeline-item" :class="{ 'is-current': item.current }">
                <div class="portfolio-timeline-marker" aria-hidden="true">{{ String(index + 1).padStart(2, '0') }}</div>
                <div class="portfolio-timeline-card">
                  <div class="portfolio-timeline-meta"><span>{{ item.when }}</span><span class="portfolio-timeline-tag" :class="{ 'is-current-tag': item.current }">{{ item.status }}</span></div>
                  <h3>{{ item.title }}</h3>
                  <p class="portfolio-timeline-org">{{ item.org }}</p>
                  <p class="portfolio-timeline-description">{{ item.description }}</p>
                  <ul class="portfolio-timeline-skills"><li v-for="skill in item.skills" :key="skill">{{ skill }}</li></ul>
                  <details class="portfolio-timeline-detail">
                    <summary>{{ item.detailLabel }} <span aria-hidden="true">＋</span></summary>
                    <p>{{ item.detail }}</p>
                    <a v-if="item.link" :href="item.link">{{ item.linkLabel }} ↗</a>
                  </details>
                </div>
              </article>
            </div>
            <div class="timeline-marquee-group" aria-hidden="true" inert>
              <article v-for="(item, index) in visibleJourneyItems" :key="'copy-' + item.id" class="portfolio-timeline-item" :class="{ 'is-current': item.current }">
                <div class="portfolio-timeline-marker" aria-hidden="true">{{ String(index + 1).padStart(2, '0') }}</div>
                <div class="portfolio-timeline-card">
                  <div class="portfolio-timeline-meta"><span>{{ item.when }}</span><span class="portfolio-timeline-tag" :class="{ 'is-current-tag': item.current }">{{ item.status }}</span></div>
                  <h3>{{ item.title }}</h3>
                  <p class="portfolio-timeline-org">{{ item.org }}</p>
                  <p class="portfolio-timeline-description">{{ item.description }}</p>
                  <ul class="portfolio-timeline-skills"><li v-for="skill in item.skills" :key="skill">{{ skill }}</li></ul>
                  <details class="portfolio-timeline-detail">
                    <summary>{{ item.detailLabel }} <span aria-hidden="true">＋</span></summary>
                    <p>{{ item.detail }}</p>
                    <a v-if="item.link" :href="item.link">{{ item.linkLabel }} ↗</a>
                  </details>
                </div>
              </article>
            </div>
          </div>
          <p v-else class="timeline-empty">No milestones in this category yet. Choose another filter to explore the journey.</p>
        </div>

        <div class="journey-finale"><span aria-hidden="true">✳</span><p>THE NEXT CHAPTER IS STILL BEING WRITTEN</p></div>
        <div class="journey-bottom-grid">
          <article class="explore-card"><small>CURRENTLY EXPLORING</small><h3>Small details, better experiences.</h3><p>Accessibility · interaction design · data visualisation</p><span class="feature-label">NOW LEARNING · ALWAYS ITERATING</span></article>
          <article class="explore-card terminal-card"><small>A LITTLE DEVELOPER MAGIC</small><h3>Try the mini terminal.</h3><div class="terminal-window"><div class="terminal-dots"><i></i><i></i><i></i></div><p class="terminal-prompt">zanda@portfolio:~$ <span>help</span></p><p class="terminal-output" aria-live="polite">{{ terminalOutput }}</p><form @submit.prevent="runTerminal"><label for="terminal-command">zanda@portfolio:~$ </label><input id="terminal-command" v-model="terminalCommand" autocomplete="off" placeholder="type a command…" /></form></div><span class="feature-label">TRY: help · about · skills · projects · contact</span></article>
        </div>
      </section>


      <section id="blog" class="page-wrap content-section portfolio-data-section">
        <p class="section-kicker"><span>05</span> NOTES FROM THE JOURNEY</p>
        <div class="work-heading">
          <h2>A little <em>field journal.</em></h2>
          <p>Small lessons from building for the web.</p>
        </div>
        <div v-if="blogPosts.length" class="journal-archive">
          <div class="journal-archive-head">
            <div><span class="journal-issue-label">FIELD NOTES · VOL. 01</span><p>Learning notes, one entry at a time.</p></div>
            <span class="journal-update-stamp">LAST UPDATED<br /><b>OCT 2026</b></span>
          </div>
          <div class="journal-index" role="group" aria-label="Browse field journal entries">
            <button v-for="(post, index) in blogPosts" :key="post.slug" type="button" class="journal-index-item" :class="{ 'is-active': currentJournalIndex === index }" :aria-pressed="currentJournalIndex === index" @click="currentJournalIndex = index">
              <span class="journal-index-number">0{{ index + 1 }}</span><span class="journal-index-copy"><b>{{ post.title }}</b><small>{{ post.category }}</small></span><span class="journal-index-arrow" aria-hidden="true">↗</span>
            </button>
          </div>
          <div class="journal-carousel" aria-roledescription="carousel" aria-label="Selected field journal entry">
          <article class="journal-slide" :class="'journal-slide-' + (currentJournalIndex + 1)" :key="currentJournalPost.slug" aria-live="polite">
            <div class="journal-image-wrap">
              <img class="journal-image" :src="currentJournalPost.imageUrl" :alt="currentJournalPost.imageAlt" loading="lazy" />
              <span class="journal-image-note">{{ currentJournalPost.imageNote }}</span>
              <span class="journal-image-spark" aria-hidden="true">✳</span>
            </div>
            <div class="journal-copy">
              <p class="project-meta">{{ currentJournalPost.category }} <span>·</span> {{ currentJournalPost.publishedAt }} <span>·</span> {{ currentJournalPost.readingMinutes }} MIN READ</p>
              <p class="journal-number">FIELD NOTE 0{{ currentJournalIndex + 1 }} <span> / 0{{ blogPosts.length }}</span></p>
              <h3>{{ currentJournalPost.title }}</h3>
              <p class="blog-excerpt journal-excerpt">{{ currentJournalPost.excerpt }}</p>
              <p class="journal-takeaway"><span aria-hidden="true">✳</span><span><small>THE TAKEAWAY</small>{{ currentJournalPost.takeaway }}</span></p>
              <div class="journal-tags" aria-label="Topics in this entry"><span v-for="tag in currentJournalPost.tags" :key="tag">{{ tag }}</span></div>
              <details class="case-study journal-details">
                <summary>Read the full reflection <span aria-hidden="true">↗</span></summary>
                <p class="blog-content">{{ currentJournalPost.content }}</p>
              </details>
              <div class="journal-controls">
                <button type="button" class="journal-arrow" aria-label="Previous journal entry" @click="moveJournal(-1)">←</button>
                <div class="journal-dots" role="group" aria-label="Choose a journal entry">
                  <button v-for="(post, index) in blogPosts" :key="post.slug" type="button" class="journal-dot" :class="{ 'is-active': currentJournalIndex === index }" :aria-label="'Show entry ' + (index + 1) + ': ' + post.title" :aria-pressed="currentJournalIndex === index" @click="currentJournalIndex = index"></button>
                </div>
                <button type="button" class="journal-arrow" aria-label="Next journal entry" @click="moveJournal(1)">→</button>
              </div>
            </div>
          </article>
          <p class="journal-footnote"><span>✳</span><span class="journal-footnote-text">NOTES FROM A DEVELOPER IN PROGRESS — ALWAYS LEARNING, ALWAYS MAKING</span></p>
          </div>
        </div>
      </section>

      <section id="achievements" class="work-section">
        <div class="page-wrap content-section portfolio-data-section">
          <p class="section-kicker"><span>06</span> LITTLE MILESTONES, BIG MEANING</p>
          <div class="work-heading">
            <h2>Proof of <em>progress.</em></h2>
            <p>Credentials and milestones, earned one step at a time.</p>
          </div>
          <div class="credential-sections">
            <section class="credential-group" aria-labelledby="completed-credentials-heading">
              <div class="credential-group-heading">
                <h3 id="completed-credentials-heading">Completed credentials</h3>
                <p>Certificates and badges that can be verified.</p>
              </div>
              <p v-if="!completedAchievements.length" class="api-note">
                Verified credentials will be listed here once their completion details and public verification links are confirmed.
              </p>
              <div v-else class="achievement-grid">
                <article v-for="item in completedAchievements" :key="item.achievement_id" class="achievement-card">
                  <img v-if="item.imageUrl" class="credential-image" :src="item.imageUrl" :alt="item.title + ' badge or certificate'" loading="lazy" />
                  <span v-else class="achievement-icon" aria-hidden="true">✳</span>
                  <p class="project-meta">COMPLETED<span v-if="item.achievedOn"> · {{ new Date(item.achievedOn).toLocaleDateString('en-ZA', { year: 'numeric', month: 'short', day: 'numeric', timeZone: 'UTC' }) }}</span></p>
                  <h4>{{ item.title }}</h4>
                  <p class="achievement-issuer">{{ item.issuer }}</p>
                  <p class="blog-excerpt">{{ item.description }}</p>
                  <a v-if="item.credentialUrl" class="project-link" :href="item.credentialUrl" target="_blank" rel="noopener noreferrer">Verify credential ↗</a>
                  <p v-else class="credential-unverified">Public verification link not supplied.</p>
                </article>
              </div>
            </section>
            <section class="credential-group" aria-labelledby="learning-credentials-heading">
              <div class="credential-group-heading">
                <h3 id="learning-credentials-heading">In progress & planned learning</h3>
                <p>Journey milestones, separate from verified credentials.</p>
              </div>
              <p v-if="!learningAchievements.length" class="api-note">No in-progress or planned learning items have been listed yet.</p>
              <div class="achievement-grid learning-experience-grid">
                <article v-for="item in learningExperiences" :key="item.id" class="achievement-card learning-experience-card">
                  <span class="achievement-icon" aria-hidden="true">{{ item.id === 'lc-studio-internship' ? '✦' : '✳' }}</span>
                  <img v-if="item.imageUrl" class="credential-image learning-experience-image" :src="item.imageUrl" :alt="item.title + ' at ' + item.issuer" loading="lazy" />
                  <p class="project-meta">{{ item.statusLabel }}</p>
                  <h4>{{ item.title }}</h4>
                  <p class="achievement-issuer">{{ item.issuer }}</p>
                  <p class="learning-period">{{ item.period }}</p>
                  <p class="blog-excerpt">{{ item.description }}</p>
                </article>
                <article v-for="item in learningAchievements" :key="item.achievement_id" class="achievement-card">
                  <span class="achievement-icon" aria-hidden="true">✳</span>
                  <p class="project-meta">{{ item.status === 'planned' ? 'PLANNED' : 'IN PROGRESS' }}</p>
                  <h4>{{ item.title }}</h4>
                  <p class="achievement-issuer">{{ item.issuer }}</p>
                  <p class="blog-excerpt">{{ item.description }}</p>
                </article>
              </div>
            </section>
          </div>
        </div>
      </section>

      <section id="contact" class="contact-section">
        <div class="page-wrap contact-inner">
          <p class="section-kicker"><span>07</span> THE NEXT CHAPTER</p>
          <p class="contact-overline">GOOD THINGS START WITH A HELLO</p>
          <h2>Have a good feeling<br />about <em>this?</em></h2>
          <p class="contact-description">Curious people, good ideas and thoughtful teams — say hello.</p>
          <form
            class="contact-form"
            action="https://formspree.io/f/xdearnka"
            method="POST"
          >
            <div class="contact-form-row">
              <label for="contact-name">
                YOUR NAME
                <input
                  id="contact-name"
                  type="text"
                  name="name"
                  placeholder="What should I call you?"
                  autocomplete="name"
                  required
                />
              </label>
              <label for="contact-email">
                EMAIL ADDRESS
                <input
                  id="contact-email"
                  type="email"
                  name="email"
                  placeholder="you@example.com"
                  autocomplete="email"
                  required
                />
              </label>
            </div>
            <label for="contact-subject">
              SUBJECT
              <input
                id="contact-subject"
                type="text"
                name="_subject"
                placeholder="What would you like to talk about?"
                required
              />
            </label>
            <label for="contact-message">
              YOUR MESSAGE
              <textarea
                id="contact-message"
                name="message"
                rows="5"
                placeholder="Tell me a little about your idea..."
                required
              ></textarea>
            </label>
            <input
              class="honeypot"
              type="text"
              name="_gotcha"
              tabindex="-1"
              autocomplete="off"
              aria-hidden="true"
            />
            <button class="contact-button" type="submit">SEND MESSAGE ↗</button>
            <p class="contact-form-note">Your message will be sent securely through Formspree. Please don't include sensitive information.</p>
          </form>

          <div class="social-links" aria-label="Social links">
            <a class="social-link" href="https://github.com/Zandakumsha" target="_blank" rel="noopener noreferrer" aria-label="Visit Zanda's GitHub profile">
              <svg class="social-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path fill="currentColor" d="M12 .9a11.1 11.1 0 0 0-3.51 21.63c.55.1.76-.24.76-.54v-2.08c-3.1.67-3.76-1.32-3.76-1.32-.5-1.28-1.24-1.62-1.24-1.62-1.01-.69.08-.68.08-.68 1.12.08 1.71 1.15 1.71 1.15 1 .1.76 2.02 3.23 1.44.1-.72.39-1.21.7-1.49-2.47-.28-5.07-1.24-5.07-5.5 0-1.22.44-2.22 1.15-3-.12-.28-.5-1.42.11-2.96 0 0 .94-.3 3.05 1.15a10.6 10.6 0 0 1 5.55 0c2.12-1.44 3.05-1.15 3.05-1.15.61 1.54.23 2.68.12 2.96.71.78 1.14 1.78 1.14 3.01 0 4.27-2.6 5.21-5.08 5.49.4.34.75 1 .75 2.02v3c0 .3.2.65.77.54A11.1 11.1 0 0 0 12 .9Z"/></svg>
              <span>GitHub</span><span class="social-arrow" aria-hidden="true">↗</span>
            </a>
            <a class="social-link" href="https://www.linkedin.com/" target="_blank" rel="noopener noreferrer" aria-label="Open LinkedIn">
              <svg class="social-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path fill="currentColor" d="M20.45 2H3.55C2.69 2 2 2.68 2 3.52v16.96c0 .84.69 1.52 1.55 1.52h16.9c.86 0 1.55-.68 1.55-1.52V3.52c0-.84-.69-1.52-1.55-1.52ZM7.93 18.7H4.98V9.2h2.95v9.5ZM6.45 7.9a1.71 1.71 0 1 1 0-3.42 1.71 1.71 0 0 1 0 3.42Zm12.25 10.8h-2.94v-4.62c0-1.1-.02-2.51-1.53-2.51-1.53 0-1.76 1.19-1.76 2.43v4.7H9.53V9.2h2.82v1.3h.04c.39-.74 1.35-1.52 2.78-1.52 2.97 0 3.53 1.95 3.53 4.48v5.24Z"/></svg>
              <span>LinkedIn</span><span class="social-arrow" aria-hidden="true">↗</span>
            </a>
            <a class="social-link social-back-to-top" href="#home" aria-label="Back to top"><span aria-hidden="true">↑</span><span>Back to top</span></a>
          </div>
        </div>
      </section>
    </main>

    <footer class="site-footer">
      <a class="brand-mark footer-mark" href="#home">z.</a>
      <p>Designed with care <span>♡</span> and a little bit of caffeine.</p>
      <small>© 2026 ZANDA K.</small>
    </footer>
    <CursorGlow />
  </div>
</template>


