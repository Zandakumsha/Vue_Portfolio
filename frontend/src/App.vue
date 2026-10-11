<script setup>
import { onMounted, ref } from 'vue'
import { apiRequest } from './services/api.js'

const isDark = ref(false)
const selectedSkill = ref('')
const terminalCommand = ref('')
const terminalOutput = ref('Try: help, about, skills, projects, contact')
const emailCopied = ref(false)
const cvDataUrl = 'data:text/plain;charset=utf-8,' + encodeURIComponent('ZANDA K. — DEVELOPER\n\nGitHub: https://github.com/Zandakumsha\nSkills: Vue.js, JavaScript, HTML, CSS, Node.js, Express, MySQL, Python, Flask, Git and GitHub.\nProjects: WeConnect, Modern Tech, Lightning News.\n\nDemo CV — replace with your real CV before publishing.')

const menuOpen = ref(false)
const blogPosts = ref([])
const achievements = ref([])
const blogError = ref('')
const achievementsError = ref('')
const projectsError = ref('')
const apiStatus = ref('loading')
const contactForm = ref({ name: '', email: '', subject: '', message: '', website: '' })
const contactSubmitting = ref(false)
const contactStatus = ref('')
const contactStatusType = ref('success')

onMounted(async () => {
  const results = await Promise.allSettled([
    apiRequest('/projects'),
    apiRequest('/blog'),
    apiRequest('/achievements'),
  ])

  const [projectResult, blogResult, achievementResult] = results
  apiStatus.value = results.every((result) => result.status === 'fulfilled')
    ? 'connected'
    : results.some((result) => result.status === 'fulfilled')
      ? 'partial'
      : 'offline'

  if (projectResult.status === 'fulfilled' && Array.isArray(projectResult.value)) {
    // Keep the designed examples when the database has no published projects yet.
    // The API/database does not store individual contribution lists, so preserve those
    // verified frontend details when published project records replace the examples.
    if (projectResult.value.length) {
      const savedProjects = projects.value
      projects.value = projectResult.value.map((apiProject) => {
        const savedProject = savedProjects.find((project) =>
          project.name === apiProject.name ||
          project.number === String(apiProject.number).padStart(2, '0'),
        )

        return {
          ...savedProject,
          ...apiProject,
          contributions: apiProject.contributions ?? savedProject?.contributions,
        }
      })
    }
    projectsError.value = ''
  } else {
    projectsError.value = 'The project API is unavailable. Showing the saved portfolio examples instead.'
  }

  if (blogResult.status === 'fulfilled' && Array.isArray(blogResult.value)) {
    blogPosts.value = blogResult.value
    blogError.value = ''
  } else {
    blogError.value = 'Blog posts could not be loaded from the API. Please check the backend and database.'
  }

  if (achievementResult.status === 'fulfilled' && Array.isArray(achievementResult.value)) {
    achievements.value = achievementResult.value
    achievementsError.value = ''
  } else {
    achievementsError.value = 'Achievements could not be loaded from the API. Please check the backend and database.'
  }
})

async function submitContact() {
  contactSubmitting.value = true
  contactStatus.value = ''
  try {
    const result = await apiRequest('/contact', {
      method: 'POST',
      body: JSON.stringify(contactForm.value),
    })
    contactStatusType.value = 'success'
    contactStatus.value = result.message || 'Thank you — your message has been received.'
    contactForm.value = { name: '', email: '', subject: '', message: '', website: '' }
  } catch (error) {
    contactStatusType.value = 'error'
    contactStatus.value = error.message || 'Your message could not be sent. Please try again.'
  } finally {
    contactSubmitting.value = false
  }
}

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
    contributionNote: 'Personalise this section with the pages, routes, authentication or database features you personally implemented.',
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
async function copyEmail() {
  const email = 'hello@zandaportfolio.dev'
  try { await navigator.clipboard.writeText(email); emailCopied.value = true }
  catch { emailCopied.value = false; window.location.href = 'mailto:' + email }
}
</script>

<template>
  <div class="site-shell" :class="{ 'theme-dark': isDark }">
    <div class="announcement">
      <span class="status-dot"></span>
      <span>OPEN TO NEW OPPORTUNITIES</span>
      <span class="announcement-flower">✳</span>
      <span>Building thoughtful things for the web</span>
    </div>

    <header class="topbar">
      <a class="brand" href="#home" aria-label="Zanda home" @click="closeMenu">
        <span class="brand-mark">z.</span>
        <span class="brand-copy">ZANDA K.<small>DEVELOPER & CREATIVE THINKER</small></span>
      </a>
      <button
        class="menu-toggle"
        type="button"
        :aria-expanded="menuOpen"
        aria-controls="main-navigation"
        @click="menuOpen = !menuOpen"
      >
        {{ menuOpen ? 'Close −' : 'Menu +' }}
      </button>
      <nav id="main-navigation" class="navigation" :class="{ 'navigation-open': menuOpen }" aria-label="Main navigation">
        <a href="#about" @click="closeMenu">About</a>
        <a href="#work" @click="closeMenu">Selected work</a>
        <a href="#skills" @click="closeMenu">Expertise</a>
        <a href="#journey" @click="closeMenu">Journey</a>
        <a href="#blog" @click="closeMenu">Journal</a>
        <a href="#achievements" @click="closeMenu">Milestones</a>
        <a class="nav-contact" href="#contact" @click="closeMenu">Let's talk ↗</a>
      </nav>
      <button class="theme-toggle" type="button" :aria-pressed="isDark" @click="isDark = !isDark">{{ isDark ? "☼ Light mode" : "☾ Dark mode" }}</button>
    </header>

    <main>
      <section id="home" class="hero page-wrap">
        <div class="hero-copy">
          <p class="eyebrow">HELLO, WORLD. I'M ZANDA.</p>
          <h1>Soft heart.<br />Sharp <em>mind.</em><br />Beautifully<br />built <span class="green-word">code.</span></h1>
          <p class="hero-description">
            I'm a developer who loves turning complex ideas into thoughtful, intuitive digital experiences — one considered detail at a time.
          </p>
          <div class="hero-actions">
            <a class="button-primary" href="#work">Explore my work <span>↗</span></a>
            <a class="text-link" href="#about">A little about me ↓</a>
            <a class="cv-download" :href="cvDataUrl" download="Zanda-K-Demo-CV.txt">Download CV ↗</a>
          </div>
          <p class="little-note"><span>✳</span> Curious by nature. Intentional by design.</p>
        </div>

        <div class="hero-art" aria-label="Portrait and creative details">
          <div class="portrait-backdrop"></div>
          <div class="portrait-frame">
            <img
              src="/public/Screenshot 2026-06-05 184643.png"
              alt="Editorial portrait representing a confident woman"
            />
            <span class="portrait-caption">01 / THE PERSON BEHIND THE PIXELS</span>
          </div>
          <div class="creative-sticker"><b>✳</b><span>CREATIVE<br />THINKING</span></div>
          <div class="intention-sticker">✳<br />made with<br /><em>intention</em></div>
          <div class="orbit-line"></div>
          <span class="hero-spark">✴</span>
        </div>
        <div class="scroll-cue"><span>SCROLL TO DISCOVER</span><i></i><span>01 — 05</span></div>
      </section>

      <div class="manifesto">
        <div class="manifesto-inner">
          <span class="mini-label">MY LITTLE PHILOSOPHY</span>
          <p>Good technology should feel <em>human.</em><br />Great design should feel <em>effortless.</em></p>
          <span class="manifesto-flower">✳</span>
        </div>
      </div>

      <section id="about" class="page-wrap content-section">
        <p class="section-kicker"><span>01</span> A NOTE ABOUT ME</p>
        <div class="about-grid">
          <div>
            <h2>Equal parts<br /><em>logic</em> & lovely.</h2>
            <p class="handwritten">and always learning ↗</p>
          </div>
          <div class="body-copy">
            <p class="statement">I believe the best digital experiences live where clean engineering meets a little bit of magic.</p>
            <p>I'm Zanda, a developer growing my craft across frontend and backend technologies. I enjoy shaping ideas into useful products, untangling tricky problems and making the details feel just as considered as the big picture.</p>
            <p>My approach is curious, collaborative and people-first. I'm here to keep learning, build with purpose and create technology that makes someone's day a little easier.</p>
            <a class="under-link" href="#contact">Have a project in mind? <span>Let's connect ↗</span></a>
          </div>
        </div>
        <div class="values-row">
          <div class="value-item"><span class="value-icon">✳</span><div><strong>Thoughtful by design</strong><small>Details matter. People matter more.</small></div></div>
          <div class="value-item"><span class="value-icon">♡</span><div><strong>Always evolving</strong><small>Curiosity is part of the process.</small></div></div>
          <div class="value-item"><span class="value-icon">⌘</span><div><strong>Built to be useful</strong><small>Beautiful is better when it works.</small></div></div>
        </div>
      </section>

      <section id="work" class="work-section">
        <div class="page-wrap content-section">
          <p class="section-kicker"><span>02</span> A FEW THINGS I'VE BUILT</p>
          <div class="work-heading">
            <h2>A collection of<br /><em>curiosity.</em></h2>
            <p>Different challenges, one common thread: making technology more useful, clear and human.</p>
          </div>
          <p v-if="apiStatus === 'connected'" class="api-note api-connected" role="status">Live projects, journal posts and achievements are connected to the backend.</p>
          <p v-if="projectsError" class="api-note" role="status">{{ projectsError }}</p>
          <div class="project-grid">
            <article v-for="project in projects" :key="project.number" :id="'project-' + project.number" class="project-card" :class="{ 'project-muted': selectedSkill && !project.tags.some(tag => selectedSkill.toLowerCase().includes(tag.toLowerCase()) || tag.toLowerCase().includes(selectedSkill.toLowerCase()) || project.description.toLowerCase().includes(selectedSkill.toLowerCase())) }">
              <a class="project-art" :class="project.theme" :href="project.url" target="_blank" rel="noreferrer" :aria-label="'Open ' + project.name">
                <span class="art-label">{{ project.number }} / CASE STUDY</span>
                <span class="art-star">✳</span>
                <img
                  v-if="project.name === 'Lightning News'"
                  class="project-screenshot"
                  src="https://i.ibb.co/bj7C9TgS/Screenshot-2026-10-11-015612.png"
                  alt="Lightning News analytics dashboard showing its topic network and news article cards"
                  loading="lazy"
                />
                <div v-else class="mock-window">
                  <div class="window-bar"><i></i><i></i><i></i><small>studio / {{ project.initials.toLowerCase() }}</small></div>
                  <div class="window-content"><b>{{ project.initials }}</b><span class="mock-lines"><i></i><i></i><i></i></span><span class="mock-arrow">↗</span></div>
                </div>
                <span class="art-foot">VIEW PROJECT ↗</span>
              </a>
              <p class="project-meta">{{ project.type }}</p>
              <h3>{{ project.name }}</h3>
              <p class="project-description">{{ project.description }}</p>
              <section v-if="project.contributions" class="personal-contributions" :aria-label="'My individual contributions to ' + project.name">
                <h4>My individual contributions</h4>
                <ul>
                  <li v-for="contribution in project.contributions" :key="contribution">{{ contribution }}</li>
                </ul>
                <p class="team-context">Individual work within a wider team project.</p>
              </section>
              <div class="tag-list"><span v-for="tag in project.tags" :key="tag">{{ tag }}</span></div>
              <a class="project-link" :href="project.url" target="_blank" rel="noreferrer">{{ project.label }} <span>↗</span></a>
              <details class="case-study">
                <summary>Inside the project +</summary>
                <div class="case-study-content">
                  <p><strong>Project focus</strong>{{ project.focus }}</p>
                  <p><strong>The challenge</strong>{{ project.challenge }}</p>
                  <p><strong>My approach</strong>{{ project.approach }}</p>
                  <p><strong>What it taught me</strong>{{ project.learning }}</p>
                  <div v-if="project.contributions" class="contribution-note">
                    <strong>My individual contributions</strong>
                    <ul>
                      <li v-for="contribution in project.contributions" :key="contribution">{{ contribution }}</li>
                    </ul>
                    <p class="team-context">These are my confirmed contributions within a wider team project; the overall project description covers the team deliverable.</p>
                  </div>
                  <p v-else-if="project.contributionNote" class="contribution-note">{{ project.contributionNote }}</p>
                </div>
              </details>
            </article>
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
        <p class="journey-intro">A little timeline for the work, learning and curiosity that keep shaping how I build. Update these milestones as your journey evolves.</p>
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
        <p v-if="blogError" class="api-note" role="status">{{ blogError }}</p>
        <p v-else-if="!blogPosts.length" class="api-note">New notes are on the way. Check back soon.</p>
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
          <p v-if="achievementsError" class="api-note" role="status">{{ achievementsError }}</p>
          <p v-else-if="!achievements.length" class="api-note">Achievements will appear here as they are added.</p>
          <div v-else class="achievement-grid">
            <article v-for="item in achievements" :key="item.achievement_id" class="achievement-card">
              <span class="achievement-icon">✳</span>
              <p class="project-meta">{{ item.category }}<span v-if="item.achievedOn"> · {{ new Date(item.achievedOn).toLocaleDateString('en-ZA', { year: 'numeric', month: 'short' }) }}</span></p>
              <h3>{{ item.title }}</h3>
              <p class="achievement-issuer">{{ item.issuer }}</p>
              <p class="blog-excerpt">{{ item.description }}</p>
              <a v-if="item.credentialUrl" class="project-link" :href="item.credentialUrl" target="_blank" rel="noreferrer">View credential ↗</a>
            </article>
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
          <form class="contact-form" @submit.prevent="submitContact">
            <div class="contact-form-row">
              <label>
                Your name
                <input v-model.trim="contactForm.name" name="name" type="text" autocomplete="name" minlength="2" maxlength="100" required placeholder="What should I call you?" />
              </label>
              <label>
                Email address
                <input v-model.trim="contactForm.email" name="email" type="email" autocomplete="email" maxlength="254" required placeholder="you@example.com" />
              </label>
            </div>
            <label>
              Subject <span class="optional-label">OPTIONAL</span>
              <input v-model.trim="contactForm.subject" name="subject" type="text" maxlength="150" placeholder="A little about your idea" />
            </label>
            <label>
              Your message
              <textarea v-model.trim="contactForm.message" name="message" minlength="10" maxlength="5000" required rows="4" placeholder="Tell me what you're thinking…"></textarea>
            </label>
            <label class="honeypot" aria-hidden="true">
              Leave this field empty
              <input v-model="contactForm.website" name="website" tabindex="-1" autocomplete="off" />
            </label>
            <button class="contact-button" type="submit" :disabled="contactSubmitting">
              {{ contactSubmitting ? 'Sending your note…' : 'Send a little hello ↗' }}
            </button>
            <p v-if="contactStatus" class="contact-status" :class="'status-' + contactStatusType" role="status" aria-live="polite">{{ contactStatus }}</p>
          </form>
          <div class="social-links">
            <a href="https://github.com/Zandakumsha" target="_blank" rel="noreferrer">GITHUB ↗</a><span>·</span>
            <a href="mailto:hello@zandaportfolio.dev">EMAIL ↗</a><span>·</span>
            <button class="copy-email" type="button" @click="copyEmail">{{ emailCopied ? "EMAIL COPIED ✓" : "COPY EMAIL" }}</button><span>·</span>
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

<style>
@import url('https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=DM+Sans:wght@400;500;600;700&family=Playfair+Display:ital,wght@1,500;1,600&display=swap');

:root {
  font-family: 'DM Sans', sans-serif;
  color: #382f2e;
  background: #fbf8f5;
  font-synthesis: none;
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  --paper: #fbf8f5;
  --ink: #382f2e;
  --muted: #887977;
  --rose: #a9656e;
  --line: #e9dfd9;
  --soft: #f0e6e0;
  --sage: #dfe4d7;
  --serif: 'Playfair Display', Georgia, serif;
  --mono: 'DM Mono', monospace;
}
* { box-sizing: border-box; }
html { scroll-behavior: smooth; scroll-padding-top: 108px; }
body { margin: 0; min-width: 320px; }
[id] { scroll-margin-top: 108px; }
:focus-visible { outline: 3px solid var(--rose); outline-offset: 4px; border-radius: 5px; }
::selection { background: var(--sage); color: var(--ink); }
a { color: inherit; text-decoration: none; }
button { font: inherit; }
.site-shell { min-height: 100vh; overflow: clip; background: var(--paper); }
.announcement { min-height: 34px; padding: 7px 16px; background: var(--soft); display: flex; align-items: center; justify-content: center; gap: 10px; font: 9px var(--mono); letter-spacing: .1em; color: var(--muted); }
.status-dot { width: 6px; height: 6px; border-radius: 50%; background: #8c9c7d; box-shadow: 0 0 0 3px #8c9c7d2a; }
.announcement-flower { color: var(--rose); }
.topbar { position: sticky; top: 0; z-index: 50; max-width: 1200px; height: 84px; padding: 0 34px; margin: auto; display: flex; align-items: center; justify-content: space-between; gap: 18px; background: var(--paper); border-bottom: 1px solid var(--line); box-shadow: 0 8px 24px #49373308; transition: background .2s ease, border-color .2s ease; }
.brand { display: flex; align-items: center; gap: 11px; }
.brand-mark { color: var(--rose); font: italic 39px var(--serif); }
.brand-copy { font-size: 12px; font-weight: 700; letter-spacing: .14em; }
.brand-copy small { display: block; margin-top: 5px; color: var(--muted); font: 8px var(--mono); letter-spacing: .08em; }
.navigation { display: flex; align-items: center; gap: 30px; color: var(--muted); font-size: 12px; }
.navigation a { transition: color .2s ease; }
.navigation a:hover { color: var(--rose); }
.navigation .nav-contact { padding: 11px 16px; border: 1px solid #cda5a5; border-radius: 30px; color: var(--rose); }
.theme-toggle { flex-shrink: 0; border: 1px solid var(--line); border-radius: 24px; padding: 10px 12px; background: transparent; color: var(--ink); font-size: 10px; cursor: pointer; }
.cv-download { border-bottom: 1px solid #cda5a5; padding-bottom: 5px; color: var(--rose); font-size: 10px; }
.menu-toggle { display: none; border: 1px solid var(--line); border-radius: 22px; padding: 9px 13px; color: var(--ink); background: transparent; }
.page-wrap { max-width: 1130px; padding-right: 34px; padding-left: 34px; margin: 0 auto; }
.hero { position: relative; display: grid; grid-template-columns: 1fr .95fr; align-items: center; gap: 24px; min-height: 605px; padding-top: 22px; padding-bottom: 65px; }
.eyebrow, .section-kicker { display: flex; align-items: center; gap: 11px; color: var(--muted); font: 9px var(--mono); letter-spacing: .14em; }
.eyebrow::before { width: 27px; height: 1px; background: var(--rose); content: ''; }
.hero h1 { margin: 27px 0 20px; font-size: clamp(58px, 7.1vw, 83px); font-weight: 500; letter-spacing: -.075em; line-height: .99; }
h1 em, h2 em { color: var(--rose); font-family: var(--serif); font-weight: 500; letter-spacing: -.06em; }
.green-word { position: relative; color: #7e906d; }
.green-word::after { position: absolute; z-index: 0; right: 0; bottom: 2px; left: 0; height: 8px; border-radius: 50%; background: var(--sage); content: ''; transform: rotate(-2deg); }
.hero-description { max-width: 390px; margin: 24px 0; color: var(--muted); font-size: 13px; line-height: 1.95; }
.hero-actions { display: flex; flex-wrap: wrap; align-items: center; gap: 23px; }
.button-primary, .contact-button { display: inline-flex; align-items: center; gap: 22px; padding: 15px 20px; border-radius: 4px 18px 4px 18px; background: var(--rose); color: #fff9f6; font-size: 11px; transition: transform .2s ease; }
.button-primary:hover, .contact-button:hover { transform: translateY(-2px); }
.text-link { color: var(--muted); font-size: 11px; }
.little-note { margin-top: 38px; color: var(--muted); font: 9px var(--mono); }
.little-note span { margin-right: 7px; color: var(--rose); font-size: 16px; }
.hero-art { position: relative; display: grid; place-items: center; height: 485px; }
.portrait-backdrop { position: absolute; top: 9%; right: 8%; width: 75%; height: 81%; border-radius: 48% 48% 12px 12px; background: #ead9d0; transform: rotate(4deg); }
.portrait-frame { position: relative; z-index: 1; width: 67%; height: 83%; overflow: hidden; border-radius: 48% 48% 7px 7px; background: linear-gradient(145deg, #b68d7f, #e4c8bb 55%, #6e6358); }
.portrait-frame img { width: 100%; height: 100%; object-fit: cover; object-position: center 35%; filter: saturate(.78); }
.portrait-caption { position: absolute; right: 12px; bottom: 18px; left: 17px; color: #fff7f1; font: 7px var(--mono); letter-spacing: .07em; text-shadow: 0 1px 5px #222; }
.creative-sticker { position: absolute; z-index: 2; top: 14%; right: 2%; display: flex; align-items: center; padding: 13px 15px; border: 1px solid var(--line); border-radius: 5px 17px 5px 17px; background: var(--paper); box-shadow: 0 12px 28px #62474115; color: var(--muted); font: 8px/1.7 var(--mono); transform: rotate(7deg); }
.creative-sticker b { margin-right: 7px; color: var(--rose); font-size: 25px; }
.intention-sticker { position: absolute; z-index: 2; bottom: 12%; left: 2%; display: grid; width: 100px; height: 100px; place-content: center; border-radius: 50%; background: var(--sage); color: #59654e; text-align: center; font: 9px/1.4 var(--mono); transform: rotate(-9deg); }
.intention-sticker em { font: italic 16px var(--serif); }
.orbit-line { position: absolute; width: 105%; height: 26%; border: 1px solid #d9b9b7; border-radius: 50%; transform: rotate(-31deg); }
.hero-spark { position: absolute; right: 9%; bottom: 8%; color: var(--rose); font-size: 27px; }
.scroll-cue { position: absolute; right: 34px; bottom: 20px; left: 34px; display: flex; align-items: center; gap: 12px; color: var(--muted); font: 8px var(--mono); letter-spacing: .13em; }
.scroll-cue i { width: 42px; height: 1px; background: var(--line); }
.scroll-cue span:last-child { margin-left: auto; }
.manifesto { border-block: 1px solid var(--line); background: var(--soft); }
.manifesto-inner { display: flex; max-width: 1050px; min-height: 100px; align-items: center; justify-content: space-between; gap: 22px; margin: auto; padding: 22px 34px; }
.mini-label { max-width: 110px; color: var(--muted); font: 8px var(--mono); letter-spacing: .12em; }
.manifesto p { margin: 0; font: clamp(18px, 2.4vw, 22px)/1.5 var(--serif); text-align: center; }
.manifesto em { color: var(--rose); }
.manifesto-flower { color: var(--rose); font-size: 24px; }
.content-section { padding-top: 105px; padding-bottom: 105px; }
.section-kicker span { color: var(--rose); }
.section-kicker::after { width: 28px; height: 1px; background: #d5b6b1; content: ''; }
.about-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 85px; padding: 50px 0 58px; }
.about-grid h2, .work-heading h2, .skills-intro h2 { margin: 0; font-size: clamp(45px, 5vw, 62px); font-weight: 500; letter-spacing: -.065em; line-height: 1.1; }
.handwritten { margin: 25px 0 0 50px; color: #849274; font: italic 17px var(--serif); transform: rotate(-5deg); }
.body-copy { max-width: 445px; color: var(--muted); font-size: 12px; line-height: 2; }
.body-copy .statement { margin-top: 0; color: var(--ink); font: 19px/1.65 var(--serif); }
.under-link { display: inline-block; margin-top: 8px; padding-bottom: 7px; border-bottom: 1px solid #c89ba0; color: var(--rose); font-size: 11px; }
.values-row { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; padding-top: 27px; border-top: 1px solid var(--line); }
.value-item { display: flex; align-items: center; gap: 12px; }
.value-icon { display: grid; width: 38px; height: 38px; flex-shrink: 0; place-items: center; border: 1px solid var(--line); border-radius: 50%; color: var(--rose); font-size: 17px; }
.value-item strong, .value-item small { display: block; }
.value-item strong { margin-bottom: 6px; font-size: 11px; }
.value-item small { color: var(--muted); font-size: 9px; }
.work-section { border-block: 1px solid var(--line); background: var(--soft); }
.work-heading { display: flex; align-items: end; justify-content: space-between; gap: 30px; padding: 45px 0; }
.work-heading p { max-width: 300px; margin: 0 0 5px; color: var(--muted); font-size: 12px; line-height: 1.9; }
.project-grid { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 22px; }
.project-art { position: relative; display: flex; height: 270px; flex-direction: column; justify-content: space-between; overflow: hidden; padding: 16px; border-radius: 4px 24px 4px 24px; transition: transform .25s ease; }
.project-art:hover { transform: translateY(-5px); box-shadow: 0 16px 35px #49373312; }
.project-screenshot { position: absolute; inset: 0; width: 100%; height: 100%; object-fit: cover; object-position: center top; background: #fff; }
.project-art:has(.project-screenshot) { background: #fff; color: #252525; }
.project-art:has(.project-screenshot)::after { position: absolute; inset: 0; background: linear-gradient(180deg, #00000016 0%, transparent 25%, transparent 70%, #00000025 100%); content: ''; pointer-events: none; }
.project-art.rose { background: #e6c7c3; color: #714d4b; }
.project-art.lavender { background: #d9d5e3; color: #5c566e; }
.project-art.sage { background: #d8dfcf; color: #59644f; }
.art-label, .art-foot { z-index: 1; font: 8px var(--mono); letter-spacing: .1em; }
.art-foot { align-self: end; font-size: 7px; }
.art-star { position: absolute; top: 22px; right: -8px; font-size: 70px; opacity: .22; }
.mock-window { z-index: 1; width: 90%; align-self: center; overflow: hidden; border-radius: 4px 12px 4px 12px; background: #fcf8f3ed; box-shadow: 0 15px 35px #49373316; transform: rotate(-2deg); }
.window-bar { display: flex; height: 28px; align-items: center; gap: 4px; padding: 0 10px; border-bottom: 1px solid #e9dfd8; }
.window-bar i { width: 5px; height: 5px; border-radius: 50%; background: #d8b1ae; }
.window-bar i:nth-child(2) { background: #d9d7c0; }
.window-bar i:nth-child(3) { background: #b7c6aa; }
.window-bar small { margin-left: auto; color: #9b8984; font: 7px var(--mono); }
.window-content { display: flex; align-items: center; gap: 12px; padding: 20px 15px; color: #8f6568; }
.window-content > b { font: 33px var(--serif); }
.mock-lines { display: grid; flex: 1; gap: 7px; }
.mock-lines i { height: 4px; border-radius: 5px; background: #e5d8d0; }
.mock-lines i:nth-child(2) { width: 76%; }
.mock-lines i:nth-child(3) { width: 54%; }
.mock-arrow { font-size: 19px; }
.project-meta { margin: 22px 0 0; color: var(--muted); font: 8px var(--mono); letter-spacing: .08em; line-height: 1.7; }
.project-card h3 { margin: 11px 0; font: 28px var(--serif); }
.project-description { min-height: 90px; margin: 0; color: var(--muted); font-size: 12px; line-height: 1.85; }
.personal-contributions { margin-top: 16px; padding: 15px; border: 1px solid var(--line); border-radius: 4px 16px 4px 16px; background: var(--paper); }
.personal-contributions h4 { margin: 0 0 10px; color: var(--rose); font-size: 11px; font-weight: 600; }
.personal-contributions ul { display: grid; gap: 6px; margin: 0; padding-left: 17px; color: var(--muted); font-size: 10px; line-height: 1.7; }
.personal-contributions li { padding-left: 2px; }
.personal-contributions .team-context { margin: 10px 0 0; color: var(--muted); font-size: 9px; font-style: italic; line-height: 1.6; }
.tag-list { display: flex; flex-wrap: wrap; gap: 6px; margin: 16px 0; }
.tag-list span { padding: 7px 10px; border: 1px solid var(--line); border-radius: 20px; color: var(--muted); font: 9px var(--mono); }
.project-link { display: inline-flex; gap: 12px; padding-bottom: 6px; border-bottom: 1px solid #cda5a5; color: var(--rose); font-size: 10px; }
.case-study { margin-top: 12px; padding: 11px 12px; border: 1px solid var(--line); border-radius: 4px 14px 4px 14px; color: var(--muted); font-size: 10px; line-height: 1.8; }
.case-study summary { color: var(--rose); cursor: pointer; }
.case-study p { min-height: 0; margin: 9px 0 0; }
.case-study-content strong { display: block; margin-bottom: 2px; color: var(--ink); font-size: 9px; letter-spacing: .04em; }
.case-study .contribution-note { margin-top: 13px; padding-top: 10px; border-top: 1px solid var(--line); }
.case-study .contribution-note > strong { display: block; margin-bottom: 7px; color: var(--rose); font-size: 10px; font-style: normal; letter-spacing: .02em; }
.case-study .contribution-note ul { display: grid; gap: 5px; margin: 0; padding-left: 17px; font-style: normal; }
.case-study .contribution-note li { padding-left: 2px; }
.case-study .team-context { margin-top: 9px; color: var(--muted); font-size: 9px; font-style: italic; }
.project-card { transition: opacity .2s ease, transform .2s ease; }
.api-note { padding: 12px 15px; border: 1px solid var(--line); border-radius: 4px 14px 4px 14px; color: var(--muted); font-size: 11px; line-height: 1.8; }
.portfolio-data-section .work-heading { padding-top: 30px; }
.blog-grid, .achievement-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 20px; }
.blog-card, .achievement-card { padding: 24px; border: 1px solid var(--line); border-radius: 5px 22px 5px 22px; background: var(--paper); }
.blog-card h3, .achievement-card h3 { margin: 12px 0; font: 27px/1.2 var(--serif); }
.blog-excerpt { color: var(--muted); font-size: 12px; line-height: 1.9; }
.blog-content { white-space: pre-line; color: var(--muted); line-height: 1.9; }
.achievement-icon { color: var(--rose); font-size: 25px; }
.achievement-issuer { color: var(--rose); font-size: 11px; font-weight: 600; }
.contact-form { display: grid; gap: 14px; max-width: 620px; margin: 28px auto 0; text-align: left; }
.contact-form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
.contact-form label { display: grid; gap: 7px; color: #e5d4ce; font-size: 10px; letter-spacing: .04em; }
.contact-form input, .contact-form textarea { width: 100%; min-width: 0; border: 1px solid #866c67; border-radius: 4px 12px 4px 12px; padding: 12px 13px; background: #332827; color: #fff8f4; font: 12px 'DM Sans', sans-serif; outline-offset: 3px; }
.contact-form input::placeholder, .contact-form textarea::placeholder { color: #bda9a3; }
.contact-form textarea { resize: vertical; }
.contact-form .contact-button { justify-self: center; border: 0; cursor: pointer; }
.contact-form .contact-button:disabled { cursor: wait; opacity: .7; }
.optional-label { color: #bda9a3; font: 8px var(--mono); }
.honeypot { position: absolute !important; left: -10000px !important; width: 1px !important; height: 1px !important; overflow: hidden !important; }
.contact-status { margin: 0; text-align: center; font-size: 12px; line-height: 1.8; }
.status-success { color: #d7e4c8; }
.status-error { color: #ffd0cb; }
.project-card.project-muted { opacity: .38; }
.skill-pill { border-color: var(--line); background: transparent; font-family: inherit; cursor: pointer; transition: background .2s ease, border-color .2s ease; }
.skill-pill:hover, .skill-pill.skill-selected { border-color: var(--rose); background: var(--soft); }
.more-note { display: flex; align-items: center; gap: 12px; margin-top: 48px; color: var(--muted); font: 8px var(--mono); letter-spacing: .12em; }
.more-note span { color: var(--rose); font-size: 17px; }
.more-note i { height: 1px; flex: 1; background: var(--line); }
.skills-grid { display: grid; grid-template-columns: .8fr 1.2fr; align-items: center; gap: 70px; padding-top: 50px; }
.skills-intro > p:not(.handwritten) { max-width: 315px; margin-top: 22px; color: var(--muted); font-size: 12px; line-height: 2; }
.skills-intro .handwritten { margin-left: 0; }
.skills-catalog { display: grid; gap: 18px; padding: 24px; border: 1px solid var(--line); border-radius: 5px 30px 5px 30px; background: var(--paper); }
.skill-group { padding-bottom: 17px; border-bottom: 1px solid var(--line); }
.skill-group:last-of-type { padding-bottom: 0; border-bottom: 0; }
.skill-group-heading { display: flex; align-items: baseline; justify-content: space-between; gap: 12px; margin-bottom: 12px; }
.skill-group-heading h3 { margin: 0; font: 21px var(--serif); }
.skill-group-heading p { margin: 0; color: var(--muted); font-size: 9px; text-align: right; }
.skill-group-list { display: grid; gap: 10px; }
.skill-entry { min-width: 0; }
.skill-pill { display: flex; width: 100%; align-items: center; gap: 8px; padding: 11px 12px; border: 1px solid var(--line); border-radius: 18px 18px 5px 5px; color: var(--muted); font-size: 10px; text-align: left; }
.skill-pill b { color: var(--rose); font-size: 14px; }
.skill-action { margin-left: auto; color: var(--rose); font: 8px var(--mono); }
.skill-pill:hover, .skill-pill.skill-selected { border-color: var(--rose); background: var(--soft); }
.skill-projects { display: flex; flex-wrap: wrap; align-items: center; gap: 7px; margin: 7px 2px 0; }
.skill-projects > span { color: var(--muted); font: 7px var(--mono); letter-spacing: .1em; }
.skill-projects a { color: var(--ink); font-size: 9px; text-decoration: underline; text-decoration-color: #cda5a5; text-underline-offset: 3px; }
.skill-projects a:hover { color: var(--rose); }
.skills-footnote { width: 100%; padding-top: 16px; border-top: 1px solid var(--line); color: var(--muted); font: italic 13px var(--serif); }
.skills-footnote b { margin-right: 6px; color: var(--rose); }
.journey-section { padding-top: 100px; padding-bottom: 100px; }
.journey-heading { max-width: 650px; margin: 24px 0 15px; font-size: clamp(38px, 5vw, 56px); font-weight: 500; letter-spacing: -.06em; line-height: 1.12; }
.journey-intro { max-width: 530px; color: var(--muted); font-size: 12px; line-height: 1.9; }
.timeline-grid { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 15px; margin-top: 32px; }
.timeline-card, .explore-card { padding: 23px; border: 1px solid var(--line); border-radius: 5px 22px 5px 22px; background: var(--paper); }
.timeline-card small, .explore-card > small { color: var(--rose); font: 8px var(--mono); letter-spacing: .1em; }
.timeline-card h3, .explore-card h3 { margin: 13px 0 8px; font: 24px var(--serif); }
.timeline-card p, .explore-card p { margin: 0; color: var(--muted); font-size: 11px; line-height: 1.8; }
.journey-bottom-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px; }
.feature-label { display: block; margin-top: 18px; color: var(--muted); font: 8px var(--mono); letter-spacing: .08em; }
.terminal-window { margin-top: 15px; padding: 17px; border-radius: 5px 18px 5px 18px; background: #292323; color: #eadbd5; font: 10px/1.8 var(--mono); }
.terminal-dots { display: flex; gap: 5px; margin-bottom: 13px; }
.terminal-dots i { width: 7px; height: 7px; border-radius: 50%; background: #c98f8b; }
.terminal-prompt span, .terminal-window label { color: #b7c9a5; }
.terminal-output { min-height: 20px; color: #b7c9a5 !important; overflow-wrap: anywhere; }
.terminal-window form { display: flex; gap: 6px; align-items: center; }
.terminal-window input { width: 100%; min-width: 0; border: 0; border-bottom: 1px solid #65504d; outline: none; padding: 7px 0; background: transparent; color: #fff; font: 10px var(--mono); }
.copy-email { border: 0; padding: 0; background: transparent; color: inherit; font: inherit; cursor: pointer; }
.site-shell.theme-dark { --paper: #201b1b; --ink: #f7eeea; --muted: #c2afaa; --rose: #e0a5ad; --line: #4b3b3b; --soft: #302626; --sage: #424b3c; color-scheme: dark; }
.site-shell.theme-dark .topbar { border-color: var(--line); box-shadow: 0 8px 24px #00000018; }
.site-shell.theme-dark .skills-cloud { background: #2a2222; }
.site-shell.theme-dark .green-word { color: #b5c9a4; }
.site-shell.theme-dark .green-word::after { background: #46523e; }
.contact-section { position: relative; overflow: hidden; padding: 80px 0 65px; background: #413332; color: #fbf5f0; text-align: center; }
.contact-inner { position: relative; z-index: 1; }
.contact-section .section-kicker { justify-content: center; color: #c7aaa2; }
.contact-section .section-kicker::after { background: #9e7a75; }
.contact-section .section-kicker span { color: #e1b5b3; }
.contact-orbit { position: absolute; top: -130px; left: -200px; width: 400px; height: 400px; border: 1px solid #94736e55; border-radius: 50%; box-shadow: 0 0 0 30px #94736e0b, 0 0 0 60px #94736e0b; }
.contact-flower { margin-top: 27px; color: #d8aaa8; font-size: 29px; }
.contact-overline { margin: 15px 0 20px; color: #d1aaa5; font: 8px var(--mono); letter-spacing: .18em; }
.contact-section h2 { margin: 0; font-size: clamp(44px, 6vw, 66px); font-weight: 500; letter-spacing: -.06em; line-height: 1.12; }
.contact-section h2 em { color: #e1b5b3; }
.contact-description { max-width: 410px; margin: 22px auto 26px; color: #d0bfba; font-size: 12px; line-height: 1.9; }
.contact-button { background: #e9d1c7; color: #443332; }
.social-links { display: flex; align-items: center; justify-content: center; gap: 15px; margin-top: 45px; color: #c6aaa3; font: 8px var(--mono); letter-spacing: .08em; }
.social-links a:hover { color: #fff; }
.site-footer { display: flex; max-width: 1130px; min-height: 80px; align-items: center; justify-content: space-between; gap: 15px; margin: auto; padding: 22px 34px; }
.footer-mark { font-size: 31px; }
.site-footer p { color: var(--muted); font: 11px var(--serif); }
.site-footer p span { color: var(--rose); }
.site-footer small { color: var(--muted); font: 8px var(--mono); letter-spacing: .08em; }

@media (max-width: 1000px) {
  .topbar { padding-right: 25px; padding-left: 25px; gap: 12px; }
  .brand-copy { font-size: 11px; }
  .menu-toggle { display: block; flex-shrink: 0; }
  .navigation { position: absolute; top: calc(100% - 1px); right: 20px; display: none; min-width: 230px; flex-direction: column; align-items: stretch; gap: 0; padding: 14px; border: 1px solid var(--line); border-radius: 7px 22px 7px 22px; background: var(--paper); box-shadow: 0 15px 35px #4b302015; }
  .navigation.navigation-open { display: flex; }
  .navigation a { padding: 13px 8px; border-bottom: 1px solid var(--line); }
  .navigation .nav-contact { margin-top: 8px; text-align: center; }
}
@media (max-width: 850px) {
  .topbar { padding: 0 25px; }
  .navigation { gap: 18px; }
  .theme-toggle { padding: 9px 10px; }
  .hero { min-height: 550px; }
  .hero-art { height: 420px; }
  .project-grid { gap: 14px; }
  .project-art { height: 225px; padding: 12px; }
  .project-description { min-height: 125px; }
  .about-grid { gap: 40px; }
  .skills-grid { gap: 30px; }
  .skills-catalog { padding: 18px; }
  .skill-pill { padding: 10px; }
}
@media (max-width: 640px) {
  .announcement { gap: 7px; font-size: 7px; }
  .topbar { height: 73px; padding: 0 21px; gap: 8px; }
  .theme-toggle { margin-left: auto; padding: 8px 9px; font-size: 9px; }
  .brand-mark { font-size: 34px; }
  .brand-copy { font-size: 10px; }
  .brand-copy small { font-size: 7px; }
  .menu-toggle { display: block; }
  .navigation { position: absolute; top: 72px; right: 14px; left: 14px; display: none; min-width: 0; flex-direction: column; align-items: stretch; gap: 0; padding: 14px; border: 1px solid var(--line); border-radius: 7px 22px 7px 22px; background: var(--paper); box-shadow: 0 15px 35px #4b302015; }
  .navigation.navigation-open { display: flex; }
  .navigation a { padding: 13px 8px; border-bottom: 1px solid var(--line); }
  .navigation .nav-contact { margin-top: 8px; text-align: center; }
  .page-wrap { padding-right: 22px; padding-left: 22px; }
  .hero { display: flex; flex-direction: column; align-items: stretch; gap: 0; padding-top: 30px; padding-bottom: 65px; }
  .hero-copy { position: relative; z-index: 2; }
  .hero h1 { margin: 23px 0 18px; font-size: clamp(58px, 13vw, 76px); }
  .hero-description { margin: 20px 0 23px; font-size: 12px; }
  .hero-actions { gap: 17px; }
  .button-primary { padding: 14px 16px; }
  .little-note { margin-top: 27px; font-size: 8px; }
  .hero-art { height: 390px; margin-top: 10px; }
  .portrait-frame { width: 68%; height: 82%; }
  .creative-sticker { top: 12%; right: 2%; }
  .intention-sticker { bottom: 9%; left: 0; width: 90px; height: 90px; }
  .scroll-cue { right: 22px; left: 22px; font-size: 7px; }
  .manifesto-inner { gap: 12px; padding: 22px; }
  .mini-label { max-width: 75px; font-size: 7px; line-height: 1.8; }
  .manifesto p { font-size: 17px; text-align: left; }
  .manifesto-flower { font-size: 19px; }
  .content-section { padding-top: 76px; padding-bottom: 76px; }
  .about-grid { grid-template-columns: 1fr; gap: 27px; padding: 36px 0 38px; }
  .about-grid h2, .work-heading h2, .skills-intro h2 { font-size: 51px; }
  .handwritten { margin-top: 17px; margin-left: 35px; }
  .body-copy .statement { font-size: 18px; }
  .values-row { grid-template-columns: 1fr; gap: 18px; padding-top: 22px; }
  .work-heading { align-items: start; flex-direction: column; gap: 17px; padding: 35px 0 30px; }
  .work-heading p { max-width: 340px; }
  .project-grid { grid-template-columns: 1fr; gap: 38px; }
  .project-art { height: 285px; padding: 16px; }
  .mock-window { width: 82%; }
  .window-content { padding: 24px 18px; }
  .project-meta { margin-top: 18px; }
  .project-card h3 { font-size: 28px; }
  .project-description { min-height: 0; max-width: 390px; }
  .more-note { gap: 12px; margin-top: 39px; font-size: 7px; letter-spacing: .06em; }
  .skills-grid { grid-template-columns: 1fr; gap: 27px; padding-top: 35px; }
  .journey-section { padding-top: 72px; padding-bottom: 72px; }
  .timeline-grid, .journey-bottom-grid, .blog-grid, .achievement-grid, .contact-form-row { grid-template-columns: 1fr; }
  .timeline-card, .explore-card { padding: 20px; }
  .theme-toggle { font-size: 8px; }
  .project-description { font-size: 12px; }
  .section-kicker { font-size: 9px; line-height: 1.8; }
  .social-links { flex-wrap: wrap; }
  .skills-intro > p:not(.handwritten) { margin-top: 17px; }
  .skills-catalog { gap: 16px; padding: 16px; }
  .skill-group-heading { align-items: flex-start; flex-direction: column; gap: 4px; }
  .skill-group-heading p { text-align: left; }
  .skill-action { font-size: 7px; }
  .skill-pill { gap: 6px; padding: 10px 11px; font-size: 9px; }
  .skill-pill small { padding-left: 6px; font-size: 7px; }
  .contact-section { padding: 68px 0 52px; }
  .contact-section h2 { font-size: 47px; }
  .contact-description { max-width: 330px; }
  .social-links { gap: 10px; margin-top: 39px; font-size: 7px; }
  .site-footer { flex-wrap: wrap; padding: 19px 22px; }
  .site-footer p { order: 3; width: 100%; margin: 0; text-align: center; }
  .site-footer small { font-size: 7px; }
}
@media (prefers-reduced-motion: reduce) {
  html { scroll-behavior: auto; }
  *, *::before, *::after { transition: none !important; }
}
</style>
