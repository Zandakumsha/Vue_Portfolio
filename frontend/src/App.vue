<script setup>
import { computed, ref } from 'vue'
import SiteHeader from './components/SiteHeader.vue'
import HeroSection from './components/HeroSection.vue'
import AboutSection from './components/AboutSection.vue'
import ProjectCard from './components/ProjectCard.vue'
import CursorGlow from './components/CursorGlow.vue'
import ToolkitSlider from './components/ToolkitSlider.vue'
import './assets/portfolio.css'

const isDark = ref(false)
const selectedSkill = ref('')
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
    [project.name, project.type, project.description, ...project.tags].some((value) => value.toLowerCase().includes(query)),
  )
})
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
    description: 'Learned foundational ways to protect personal information, devices, networks and organisational data using practices such as strong passwords, encryption and firewalls. Explored cybersecurity ethics, online privacy and career opportunities in cybersecurity.',
  },
])
const learningExperiences = ref([
  {
    id: 'life-choices-trainee',
    title: 'Trainee Developer Programme',
    issuer: 'Life Choices Coding Academy',
    statusLabel: 'TRAINEE PERIOD · COMPLETED',
    period: 'April – October 2026',
    description: 'Completed the first six-month trainee period, building my development foundations through hands-on coding, collaborative projects, problem-solving and debugging.',
  },
  {
    id: 'lc-studio-internship',
    title: 'Developer Internship',
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
    theme: 'rose',
    type: 'FULL-STACK · VUE / NODE / MYSQL',
    name: 'WeConnect',
    description: 'A supplier network experience bringing buyers, suppliers and everyday business operations into one clear workspace.',
    tags: ['Vue.js', 'Express', 'MySQL'],
    focus: 'A supplier marketplace connecting product discovery and business workflows in one workspace.',
    challenge: 'Keeping the frontend, API and relational data model aligned as supplier and buyer features evolve.',
    approach: 'Vue.js provides the interface, Express handles server-side routes, and MySQL stores structured application data.',
    learning: 'Full-stack integration, relational data, reusable UI patterns and collaborative Git workflows.',
    contributions: [
      'Vue.js sidebar and navigation for the supplier side.',
      'Supplier-side frontend pages and reusable components.',
      'Styling for the shop section of the buyer side.',
      'Express API routes and controllers.',
      'MySQL schema work, queries and database integration.',
      'Aiven database connection and deployment configuration.',
      'Testing, debugging and Git collaboration.',
    ],
    url: 'https://github.com/zahraamoerat/Project-3-E-Commerce1',
    repoUrl: 'https://github.com/zahraamoerat/Project-3-E-Commerce1',
    label: 'Explore project',
  },
  {
    number: '02',
    initials: 'MT',
    theme: 'lavender',
    type: 'HR TECHNOLOGY · WEB APPLICATION',
    name: 'Modern Tech',
    description: 'An HR management experience for employee profiles, leave requests and calendars, with thoughtful workflows at its core.',
    tags: ['JavaScript', 'Node.js', 'MySQL'],
    focus: 'A central place for employee information and everyday HR workflows such as leave requests and calendar events.',
    challenge: 'Making sure employee-specific information and protected workflows stay connected to the correct database records.',
    approach: 'The application combines employee-facing pages with Node.js and Express routes backed by MySQL data.',
    learning: 'Connecting UI states to backend logic, thinking through authentication and data relationships, and debugging API/database issues.',
    url: 'https://github.com/Zandakumsha/Modern_Tech_2',
    repoUrl: 'https://github.com/Zandakumsha/Modern_Tech_2',
    label: 'Explore project',
  },
  {
    number: '03',
    initials: 'LN',
    theme: 'sage',
    type: 'DATA · WEB SCRAPING · ANALYTICS',
    name: 'Lightning News',
    description: 'A news analytics dashboard that brings scraped stories together with search, filtering and export-friendly views.',
    tags: ['Python', 'Flask', 'Vue.js'],
    focus: 'A dashboard that gathers stories from multiple news sources and makes them easier to search and explore.',
    challenge: 'News sites can structure their pages differently, so scraped content needs to be parsed and presented consistently.',
    approach: 'BeautifulSoup supports HTML parsing, Flask exposes backend functionality, and Vue.js powers the interactive dashboard.',
    learning: 'Data extraction, handling inconsistent source markup, and joining backend scraping with frontend search and filtering.',
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

const skillGroups = [
  { name: 'Frontend', description: 'Interfaces, components and responsive layouts', skills: [
    { name: 'Vue.js', symbol: '✳', projects: [{ name: 'WeConnect', id: '01' }, { name: 'Lightning News', id: '03' }] },
    { name: 'JavaScript', symbol: '⌘', projects: [{ name: 'WeConnect', id: '01' }, { name: 'Modern Tech', id: '02' }, { name: 'Lightning News', id: '03' }] },
    { name: 'HTML & CSS', symbol: '◇', projects: [{ name: 'WeConnect', id: '01' }, { name: 'Modern Tech', id: '02' }, { name: 'Lightning News', id: '03' }] },
  ]},
  { name: 'Backend', description: 'Server routes and application logic', skills: [
    { name: 'Node.js & Express', symbol: '↗', projects: [{ name: 'WeConnect', id: '01' }, { name: 'Modern Tech', id: '02' }] },
    { name: 'Python & Flask', symbol: '✿', projects: [{ name: 'Lightning News', id: '03' }] },
  ]},
  { name: 'Databases', description: 'Structured application data', skills: [
    { name: 'MySQL', symbol: '⊹', projects: [{ name: 'WeConnect', id: '01' }, { name: 'Modern Tech', id: '02' }] },
  ]},
  { name: 'Tools', description: 'Version control and collaboration', skills: [
    { name: 'Git & GitHub', symbol: '⌘', projects: [{ name: 'WeConnect', id: '01' }, { name: 'Modern Tech', id: '02' }, { name: 'Lightning News', id: '03' }] },
  ]},
]

function closeMenu() {
  menuOpen.value = false
}
function selectSkill(skill) { selectedSkill.value = selectedSkill.value === skill ? '' : skill }
function runTerminal() {
  const command = terminalCommand.value.trim().toLowerCase()
  const replies = { help: 'Commands: help · about · skills · projects · contact', about: 'I’m Zanda — a developer who loves thoughtful, human-centred digital experiences.', skills: 'Vue.js · JavaScript · HTML/CSS · Node.js · Express · MySQL · Python · Flask', projects: 'WeConnect · Modern Tech · Lightning News', contact: 'Scroll to the contact section and say hello ✳' }
  terminalOutput.value = replies[command] || 'Command not found. Try help'
  terminalCommand.value = ''
}
</script>

<template>
  <div class="site-shell" :class="{ 'theme-dark': isDark }">
    <a class="skip-link" href="#main-content">Skip to content</a>
    <SiteHeader v-model:is-dark="isDark" v-model:menu-open="menuOpen" />

    <main id="main-content" tabindex="-1">
      <HeroSection />

      <div class="manifesto">
        <div class="manifesto-inner portfolio-status-strip">
          <span class="mini-label">CURRENT FOCUS</span>
          <p>Building, debugging and learning — one thoughtful solution at a time.</p>
          <a href="#work">Browse selected work <span aria-hidden="true">↘</span></a>
        </div>
      </div>

      <AboutSection />

      <section id="work" class="work-section">
        <div class="page-wrap content-section">
          <p class="section-kicker"><span>02</span> PROJECT ARCHIVE · SELECTED WORK</p>
          <div class="work-heading">
            <h2>Projects &amp; <em>case studies.</em></h2>
            <p>A closer look at the problems, technologies and confirmed contributions behind each project.</p>
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
              :selected-skill="selectedSkill"
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

      <section id="skills" class="page-wrap content-section">
        <p class="section-kicker"><span>03</span> TOOLS OF MY TRADE</p>
        <div class="skills-grid">
          <div class="skills-intro">
            <h2>My kind of<br /><em>toolkit.</em></h2>
            <p>A growing set of tools for bringing thoughtful ideas to life — from the pixels people see to the systems working behind the scenes.</p>
            <p class="handwritten">less noise, more meaning ✳</p>
          </div>
          <div class="skills-catalog">
            <section v-for="group in skillGroups" :key="group.name" class="skill-group">
              <div class="skill-group-heading"><h3>{{ group.name }}</h3><p>{{ group.description }}</p></div>
              <div class="skill-group-list">
                <article v-for="skill in group.skills" :key="skill.name" class="skill-entry">
                  <button type="button" class="skill-pill" :class="{ 'skill-selected': selectedSkill === skill.name }" :aria-pressed="selectedSkill === skill.name" @click="selectSkill(skill.name)">
                    <b>{{ skill.symbol }}</b>{{ skill.name }}<span class="skill-action">{{ selectedSkill === skill.name ? 'Selected ✓' : 'Highlight projects' }}</span>
                  </button>
                  <p class="skill-projects"><span>USED IN</span><a v-for="project in skill.projects" :key="project.id" :href="'#project-' + project.id">{{ project.name }} ↗</a></p>
                </article>
              </div>
            </section>
            <p class="skills-footnote"><b>♡</b> {{ selectedSkill ? "Highlighting projects connected to " + selectedSkill + ". Select again to clear." : "Choose a technology to highlight related projects, or jump directly to a project where it was used." }}</p>
          </div>
        </div>
      </section>

      <ToolkitSlider />

      <section id="journey" class="journey-section page-wrap">
        <p class="section-kicker"><span>04</span> THE JOURNEY SO FAR</p>
        <h2 class="journey-heading">Growing into my <em>next chapter.</em></h2>
        <p class="journey-intro">A snapshot of the skills and questions guiding my growth as a developer.</p>
        <p class="journey-intro journey-intro-personal">Every chapter has taught me something different. This is the path so far — and the part I’m still figuring out.</p>
        <div class="developer-timeline" aria-label="Developer journey timeline">
          <article class="developer-milestone is-complete">
            <div class="milestone-marker" aria-hidden="true"><span>01</span></div>
            <div class="milestone-card">
              <div class="milestone-topline"><small>APRIL – OCTOBER 2026</small><span class="milestone-state"><span aria-hidden="true">✓</span> COMPLETED</span></div>
              <p class="milestone-role">Trainee Developer Programme</p>
              <h3>Life Choices Coding Academy</h3>
              <p>I spent six months building my foundations in development, learning by writing code, working through bugs and collaborating on projects with other trainees.</p>
              <details class="milestone-reflection">
                <summary>What I’m taking with me <span aria-hidden="true">＋</span></summary>
                <p>I’m learning not to treat an error as a dead end. Reading the message, testing one change at a time and asking clearer questions has helped me build a more patient problem-solving process.</p>
                <a href="#project-01">See how I practised this in WeConnect ↗</a>
              </details>
              <div class="milestone-tags"><span>Development foundations</span><span>Debugging</span><span>Team projects</span></div>
            </div>
          </article>
          <article class="developer-milestone is-current">
            <div class="milestone-marker" aria-hidden="true"><span>02</span></div>
            <div class="milestone-card">
              <div class="milestone-topline"><small>OCTOBER 2026 – APRIL 2027</small><span class="milestone-state"><span aria-hidden="true">✳</span> IN PROGRESS</span></div>
              <p class="milestone-role">Developer Internship</p>
              <h3>LC Studio</h3>
              <p>I’ve started the next six months as an intern, carrying what I learned in training into a professional environment and staying open to new ways of working.</p>
              <details class="milestone-reflection">
                <summary>What I want to keep practising <span aria-hidden="true">＋</span></summary>
                <p>I want to keep asking thoughtful questions, learning from feedback, strengthening my technical decisions and understanding how small contributions fit into a wider team effort.</p>
                <a href="#blog">Read my notes from the journey ↗</a>
              </details>
              <div class="milestone-tags"><span>Practical experience</span><span>Feedback</span><span>Continued learning</span></div>
            </div>
          </article>
          <article class="developer-milestone milestone-projects">
            <div class="milestone-marker" aria-hidden="true"><span>03</span></div>
            <div class="milestone-card">
              <div class="milestone-topline"><small>ALONG THE WAY</small><span class="milestone-state">LEARNING BY BUILDING</span></div>
              <p class="milestone-role">Projects & practice</p>
              <h3>Turning lessons into working features</h3>
              <p>Projects have helped me connect the pieces — from Vue interfaces to APIs, data and the details that make an experience easier to use.</p>
              <details class="milestone-reflection">
                <summary>A lesson from the projects <span aria-hidden="true">＋</span></summary>
                <p>WeConnect helped me practise full-stack collaboration, Modern Tech challenged me to trace issues across an application, and Lightning News gave me experience parsing web content with Python and BeautifulSoup.</p>
                <a href="#work">Explore my project work ↗</a>
              </details>
              <div class="milestone-tags"><span>WeConnect</span><span>Modern Tech</span><span>Lightning News</span></div>
            </div>
          </article>
        </div>
        <div class="journey-bottom-grid">
          <article class="explore-card"><small>CURRENTLY EXPLORING</small><h3>Small details, better experiences.</h3><p>Accessibility, interaction design, data visualisation and the little moments that make an app feel thoughtful.</p><span class="feature-label">NOW LEARNING · ALWAYS ITERATING ✳</span></article>
          <article class="explore-card terminal-card"><small>A LITTLE DEVELOPER MAGIC</small><h3>Curious? Open the terminal.</h3><div class="terminal-window"><div class="terminal-dots"><i></i><i></i><i></i></div><p class="terminal-prompt">zanda@portfolio:~$ <span>help</span></p><p class="terminal-output" aria-live="polite">{{ terminalOutput }}</p><form @submit.prevent="runTerminal"><label for="terminal-command">zanda@portfolio:~$ </label><input id="terminal-command" v-model="terminalCommand" autocomplete="off" placeholder="type a command…" /></form></div><span class="feature-label">TRY: help · about · skills · projects · contact</span></article>
        </div>
      </section>

      <section id="blog" class="page-wrap content-section portfolio-data-section">
        <p class="section-kicker"><span>05</span> NOTES FROM THE JOURNEY</p>
        <div class="work-heading">
          <h2>A little <em>field journal.</em></h2>
          <p>Thoughts on learning, problem-solving and the details behind building for the web.</p>
        </div>
        <div v-if="blogPosts.length" class="journal-archive">
          <div class="journal-archive-head">
            <div><span class="journal-issue-label">FIELD NOTES · VOL. 01</span><p>A living record of what I'm learning, building and figuring out.</p></div>
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
          <p class="journal-footnote"><span>✳</span> NOTES FROM A DEVELOPER IN PROGRESS — ALWAYS LEARNING, ALWAYS MAKING</p>
          </div>
        </div>
      </section>

      <section id="achievements" class="work-section">
        <div class="page-wrap content-section portfolio-data-section">
          <p class="section-kicker"><span>06</span> LITTLE MILESTONES, BIG MEANING</p>
          <div class="work-heading">
            <h2>Proof of <em>progress.</em></h2>
            <p>Learning milestones, credentials and experiences that are shaping my developer journey.</p>
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
                <p>Training, internships and learning goals are tracked separately from completed credentials.</p>
              </div>
              <p v-if="!learningAchievements.length" class="api-note">No in-progress or planned learning items have been listed yet.</p>
              <div class="achievement-grid learning-experience-grid">
                <article v-for="item in learningExperiences" :key="item.id" class="achievement-card learning-experience-card">
                  <span class="achievement-icon" aria-hidden="true">{{ item.id === 'lc-studio-internship' ? '✦' : '✳' }}</span>
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
        <div class="contact-orbit"></div>
        <div class="page-wrap contact-inner">
          <p class="section-kicker"><span>07</span> THE NEXT CHAPTER</p>
          <div class="contact-flower">✳</div>
          <p class="contact-overline">GOOD THINGS START WITH A HELLO</p>
          <h2>Have a good feeling<br />about <em>this?</em></h2>
          <p class="contact-description">I'm always happy to connect with kind people, curious teams and ideas worth building. Let's make something meaningful.</p>
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

          <div class="social-links">
            <a href="https://github.com/Zandakumsha" target="_blank" rel="noreferrer">GITHUB ↗</a><span>·</span>
            <a href="#home">BACK TO TOP ↑</a>
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


