<script setup>
import { computed, ref } from 'vue'
import SiteHeader from './components/SiteHeader.vue'
import HeroSection from './components/HeroSection.vue'
import AboutSection from './components/AboutSection.vue'
import ProjectCard from './components/ProjectCard.vue'
import './assets/portfolio.css'

const isDark = ref(false)
const selectedSkill = ref('')
const terminalCommand = ref('')
const terminalOutput = ref('Try: help, about, skills, projects, contact')

const menuOpen = ref(false)
const blogPosts = ref([])
const achievements = ref([])
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
        <div class="manifesto-inner">
          <span class="mini-label">MY LITTLE PHILOSOPHY</span>
          <p>Good technology should feel <em>human.</em><br />Great design should feel <em>effortless.</em></p>
          <span class="manifesto-flower">✳</span>
        </div>
      </div>

      <AboutSection />

      <section id="work" class="work-section">
        <div class="page-wrap content-section">
          <p class="section-kicker"><span>02</span> A FEW THINGS I'VE BUILT</p>
          <div class="work-heading">
            <h2>A collection of<br /><em>curiosity.</em></h2>
            <p>Different challenges, one common thread: making technology more useful, clear and human.</p>
          </div>
          <div class="project-grid">
            <ProjectCard
              v-for="project in projects"
              :key="project.number"
              :project="project"
              :selected-skill="selectedSkill"
              :individual-contributions="individualContributions"
            />
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

      <section id="journey" class="journey-section page-wrap">
        <p class="section-kicker"><span>04</span> THE JOURNEY SO FAR</p>
        <h2 class="journey-heading">Growing into my <em>next chapter.</em></h2>
        <p class="journey-intro">A snapshot of the skills and questions guiding my growth as a developer.</p>
        <div class="timeline-grid">
          <article class="timeline-card"><small>FOUNDATIONS</small><h3>Learning by building</h3><p>Strengthening core web development skills through practical interfaces, responsive layouts and collaborative projects.</p></article>
          <article class="timeline-card"><small>FULL-STACK</small><h3>Connecting the pieces</h3><p>Working across Vue, Node.js, Express and MySQL to understand how polished frontends connect to useful backend systems.</p></article>
          <article class="timeline-card"><small>ALWAYS IN PROGRESS</small><h3>Curiosity, continued</h3><p>Exploring better UX, accessible interactions, clean code and ways to turn complex problems into friendly experiences.</p></article>
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
        <p v-if="!blogPosts.length" class="api-note">Journal notes will appear here as new writing is added.</p>
        <div v-else class="blog-grid">
          <article v-for="post in blogPosts" :key="post.post_id || post.slug" class="blog-card">
            <p class="project-meta">{{ post.category }} <span>·</span> {{ post.readingMinutes || 3 }} MIN READ</p>
            <h3>{{ post.title }}</h3>
            <p class="blog-excerpt">{{ post.excerpt }}</p>
            <details class="case-study">
              <summary>Read the note +</summary>
              <p class="blog-content">{{ post.content }}</p>
            </details>
            <a v-if="post.url" class="project-link" :href="post.url" target="_blank" rel="noreferrer">Read more ↗</a>
          </article>
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
                <p>Learning goals are listed separately from completed credentials.</p>
              </div>
              <p v-if="!learningAchievements.length" class="api-note">No in-progress or planned learning items have been listed yet.</p>
              <div v-else class="achievement-grid">
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
          <div class="contact-form contact-static-note">
            <p>This portfolio is a frontend-only site, so it does not store or send messages from a form.</p>
            <a class="contact-button" href="https://github.com/Zandakumsha" target="_blank" rel="noopener noreferrer">Connect on GitHub ↗</a>
          </div>

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
  </div>
</template>


