<script setup>
import { computed, ref } from 'vue'

const rooms = [
  { id: 'projects', label: 'Projects', symbol: '▧', eyebrow: 'THE WORKROOM', title: 'Things I’ve been building', description: 'A closer look at team projects, practical problem-solving and the work behind each interface.' },
  { id: 'credentials', label: 'Milestones', symbol: '✳', eyebrow: 'THE GALLERY', title: 'Small milestones, real progress', description: 'A growing collection of learning milestones and credentials, with verification where available.' },
  { id: 'toolkit', label: 'Toolkit', symbol: '⌘', eyebrow: 'THE TOOL SHELF', title: 'Tools for turning ideas into working things', description: 'Explore the technologies I’ve used and see where they show up in my project work.' },
  { id: 'journal', label: 'Field journal', symbol: '▤', eyebrow: 'THE NOTEBOOK', title: 'Notes from the learning process', description: 'Reflections on debugging, teamwork, full-stack thinking and the next chapter of my journey.' },
]
const activeRoomId = ref('projects')
const activeRoom = computed(() => rooms.find((room) => room.id === activeRoomId.value) || rooms[0])
</script>

<template>
  <section id="studio" class="page-wrap content-section digital-studio-section">
    <p class="section-kicker"><span>✳</span> A LITTLE SPACE ON THE INTERNET</p>
    <div class="studio-heading">
      <div>
        <h2>Welcome to my <em>digital studio.</em></h2>
        <p>A small interactive workspace for the things I’m learning, making and collecting along the way.</p>
      </div>
      <span class="studio-open-badge"><i aria-hidden="true"></i> STUDIO OPEN · ALWAYS LEARNING</span>
    </div>

    <div class="studio-window">
      <div class="studio-window-bar">
        <div class="studio-window-controls" aria-hidden="true"><i></i><i></i><i></i></div>
        <span class="studio-window-title">zanda.studio / workspace</span>
        <span class="studio-window-version">VOL. 01</span>
      </div>
      <div class="studio-workspace">
        <aside class="studio-sidebar" aria-label="Digital studio rooms">
          <p class="studio-sidebar-label">YOUR VISIT</p>
          <button
            v-for="room in rooms"
            :key="room.id"
            type="button"
            class="studio-room-button"
            :class="{ 'is-active': activeRoomId === room.id }"
            :aria-pressed="activeRoomId === room.id"
            @click="activeRoomId = room.id"
          >
            <span class="studio-room-symbol" aria-hidden="true">{{ room.symbol }}</span>
            <span>{{ room.label }}</span>
            <span class="studio-room-arrow" aria-hidden="true">↗</span>
          </button>
          <div class="studio-sidebar-note">
            <span aria-hidden="true">♡</span>
            <p>Made with curiosity, care and a little bit of caffeine.</p>
          </div>
        </aside>

        <div class="studio-room-content" :key="activeRoom.id">
          <div class="studio-room-topline">
            <span>{{ activeRoom.eyebrow }}</span>
            <span>ROOM 0{{ rooms.findIndex((room) => room.id === activeRoom.id) + 1 }} / 04</span>
          </div>
          <h3>{{ activeRoom.title }}</h3>
          <p class="studio-room-description">{{ activeRoom.description }}</p>

          <div v-if="activeRoom.id === 'projects'" class="studio-collection studio-project-collection">
            <a class="studio-collection-card studio-card-weconnect" href="#project-01">
              <span class="studio-card-index">01 / FULL-STACK</span>
              <span class="studio-card-art" aria-hidden="true"><b>W</b><i>↗</i></span>
              <strong>WeConnect</strong>
              <small>Vue.js · Express · MySQL</small>
              <span class="studio-card-link">Open case study ↗</span>
            </a>
            <a class="studio-collection-card studio-card-moderntech" href="#project-02">
              <span class="studio-card-index">02 / HR TECHNOLOGY</span>
              <span class="studio-card-art" aria-hidden="true"><b>M</b><i>↗</i></span>
              <strong>Modern Tech</strong>
              <small>JavaScript · Node.js · MySQL</small>
              <span class="studio-card-link">Open case study ↗</span>
            </a>
            <a class="studio-collection-card studio-card-lightning" href="#project-03">
              <span class="studio-card-index">03 / DATA & SCRAPING</span>
              <span class="studio-card-art" aria-hidden="true"><b>L</b><i>↗</i></span>
              <strong>Lightning News</strong>
              <small>Python · Flask · BeautifulSoup</small>
              <span class="studio-card-link">Open case study ↗</span>
            </a>
          </div>

          <div v-else-if="activeRoom.id === 'credentials'" class="studio-collection studio-milestone-collection">
            <article class="studio-feature-card">
              <div class="studio-credential-mark" aria-hidden="true">✳</div>
              <div>
                <span class="studio-card-index">CYBERSECURITY · CISCO</span>
                <strong>Introduction to Cybersecurity</strong>
                <p>Foundations in passwords, encryption, firewalls, privacy and ethics.</p>
                <a href="https://www.credly.com/badges/f0b44bf4-8edf-4190-8070-e1c7e6486a22/public_url" target="_blank" rel="noopener noreferrer">View public badge ↗</a>
              </div>
            </article>
            <a class="studio-journey-link" href="#achievements"><span>01</span><span><strong>Proof of progress</strong><small>Browse credentials and learning milestones</small></span><b aria-hidden="true">↗</b></a>
            <a class="studio-journey-link" href="#journey"><span>02</span><span><strong>From trainee to intern</strong><small>Life Choices Coding Academy → LC Studio</small></span><b aria-hidden="true">↗</b></a>
          </div>

          <div v-else-if="activeRoom.id === 'toolkit'" class="studio-collection studio-tool-collection">
            <a class="studio-tool-card" href="#skills"><span>01</span><b>Vue.js</b><small>Interfaces & components</small><i>↗</i></a>
            <a class="studio-tool-card" href="#skills"><span>02</span><b>JavaScript</b><small>Interactive behaviour</small><i>↗</i></a>
            <a class="studio-tool-card" href="#skills"><span>03</span><b>Node.js + Express</b><small>Server-side routes & APIs</small><i>↗</i></a>
            <a class="studio-tool-card" href="#skills"><span>04</span><b>MySQL</b><small>Relational data & queries</small><i>↗</i></a>
            <a class="studio-tool-card" href="#skills"><span>05</span><b>Python + Flask</b><small>Parsing & web applications</small><i>↗</i></a>
            <a class="studio-tool-card" href="#skills"><span>06</span><b>Git + GitHub</b><small>Version control & collaboration</small><i>↗</i></a>
            <a class="studio-room-cta" href="#skills">Explore the full toolkit <span aria-hidden="true">↗</span></a>
          </div>

          <div v-else class="studio-collection studio-journal-collection">
            <a class="studio-journal-card" href="#blog"><span class="studio-journal-stamp">FIELD NOTE 01</span><strong>Learning to trust my problem-solving process</strong><p>Slow down. Read the clues. Test one change at a time.</p><span>Read the journal ↗</span></a>
            <a class="studio-journal-card studio-journal-card-alt" href="#blog"><span class="studio-journal-stamp">FIELD NOTE 02</span><strong>Building beyond the interface</strong><p>A feature is more than the screen — follow the data.</p><span>Read the journal ↗</span></a>
            <a class="studio-room-cta" href="#blog">Open the field journal <span aria-hidden="true">↗</span></a>
          </div>

          <div class="studio-room-footer"><span aria-hidden="true">✳</span> PICK A ROOM. STAY CURIOUS.</div>
        </div>
      </div>
    </div>
    <p class="studio-footnote">A work in progress, just like me. <a href="#contact">Have an idea to share? Say hello ↗</a></p>
  </section>
</template>
